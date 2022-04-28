/*
 * Copyright (c) 2022 Surati

 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to read
 * the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software.
	
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package io.surati.gap.payment.base.module;

import io.surati.gap.admin.base.api.Module;
import io.surati.gap.web.base.menu.DashboardMenu;
import io.surati.gap.web.base.menu.Menu;
import io.surati.gap.web.base.menu.SimpleMenu;
import io.surati.gap.web.base.menu.SimpleSubmenu;
import org.cactoos.iterable.IterableOf;

import java.util.Arrays;

/**
 * Admin module.
 *
 * @since 0.1
 */
public enum PaymentBaseModule implements Module {

	PAYMENT_BASE(
		"Payment base",
		"Ce module sert de base à tous les modules de paiement."
	);

	public static void setup() {
		for (final Module mod : PaymentBaseModule.values()) {
			Module.VALUES.add(mod);
			Module.BY_CODE.put(mod.code(), mod);
		}
		for (final DashboardMenu dmenu : PaymentBaseDashboardMenu.values()) {
			DashboardMenu.VALUES.add(dmenu);
		}
		Menu.VALUES.add(
			new SimpleMenu(
				800,
				"history",
				"lnr-history",
				"Historique",
				"bg-warning",
				"Explorer vos données de production",
				new IterableOf<>(
					new SimpleSubmenu(
						1, "orders", "lnr-pointer-left", "Ordres de paiement", "/payment-order",
						new IterableOf<>(
							PaymentBaseAccess.VISUALISER_ORDRES_PAIEMENT
						),
						false
					),
					new SimpleSubmenu(
						2, "payment", "lnr-diamond", "Paiements", "/payment/list",
						new IterableOf<>(
							PaymentBaseAccess.VISUALISER_PAIEMENTS
						),
						false
					),
					new SimpleSubmenu(
						3, "reference-document", "lnr-briefcase", "Documents de référence", "/reference-document/history",
						new IterableOf<>(
							PaymentBaseAccess.VISUALISER_DOCUMENT_REF,
							PaymentBaseAccess.EDITER_DOCUMENT_REF
						),
						false
					)
				)
			)
		);
		Menu.VALUES.add(
			new SimpleMenu(
				900,
				"settings",
				"lnr-cog",
				"Paramétrage",
				"bg-info",
				"Paramétrer vos données de base",
				new IterableOf<>(
					new SimpleSubmenu(
						1, "third-party", "lnr-users", "Tiers", "/third-party",
						new IterableOf<>(
							PaymentBaseAccess.VISUALISER_TIERS,
							PaymentBaseAccess.CONFIGURER_TIERS
						),
						false
					),
					new SimpleSubmenu(
						2, "third-party-family", "lnr-database", "Familles de tiers", "/third-party-family",
						new IterableOf<>(
							PaymentBaseAccess.VISUALISER_TIERS,
							PaymentBaseAccess.CONFIGURER_TIERS
						),
						false
					)
				)
			)
		);
	}

	/**
	 * Title of access.
	 */
	private String title;

	/**
	 * Description.
	 */
	private String description;

	/**
	 * Ctor.
	 * @param title Title
	 * @param description Description
	 */
	PaymentBaseModule(final String title, final String description) {
		this.title = title;
		this.description = description;
	}
	
	/**
	 * Get title.
	 * @return Title
	 */
	@Override
	public String title() {
		return this.title;
	}

	/**
	 * Get description.
	 * @return Description
	 */
	@Override
	public String description() {
		return this.description;
	}

	/**
	 * Get Code.
	 * @return Code
	 */
	public String code() {
		return this.name();
	}
	
	@Override
	public String toString() {
		return this.title;
	}
}
