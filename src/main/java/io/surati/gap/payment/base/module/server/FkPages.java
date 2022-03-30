package io.surati.gap.payment.base.module.server;

import com.minlessika.db.Database;
import com.minlessika.db.TkTransaction;
import io.surati.gap.payment.base.module.pages.TkPaymentList;
import io.surati.gap.payment.base.module.pages.TkPaymentOrderEdit;
import io.surati.gap.payment.base.module.pages.TkPaymentOrderList;
import io.surati.gap.payment.base.module.pages.TkPaymentOrderView;
import io.surati.gap.payment.base.module.pages.TkPaymentView;
import io.surati.gap.payment.base.module.pages.TkThirdPartyEdit;
import io.surati.gap.payment.base.module.pages.TkThirdPartyList;
import io.surati.gap.payment.base.module.pages.TkThirdPartyView;
import io.surati.gap.payment.base.module.pages.TkThirdPartyFamilyEdit;
import io.surati.gap.payment.base.module.pages.TkThirdPartyFamilyList;
import io.surati.gap.payment.base.module.pages.TkThirdPartyFamilyView;
import io.surati.gap.web.base.TkSecure;
import org.takes.facets.fork.FkChain;
import org.takes.facets.fork.FkRegex;
import org.takes.facets.fork.FkWrap;

/**
 * Front for pages.
 *
 * @since 0.1
 */
public final class FkPages extends FkWrap {

	public FkPages(
		final Database source
	) {
		super(
			new FkChain(
				new FkRegex(
					"/payment/view",
					new TkSecure(
						new TkPaymentView(source),
						source
					)
				),
				new FkRegex(
					"/payment/list",
					new TkSecure(
						new TkPaymentList(source),
						source
					)
				),
				new FkRegex(
					"/third-party",
					new TkSecure(
						new TkTransaction(
							new TkThirdPartyList(source),
							source
						),
						source
					)
				),
				new FkRegex(
					"/third-party/edit",
					new TkSecure(
						new TkThirdPartyEdit(source),
						source
					)
				),
				new FkRegex(
					"/third-party/view",
					new TkSecure(
						new TkThirdPartyView(source),
						source
					)
				),
				new FkRegex(
					"/payment-order",
					new TkSecure(
						new TkPaymentOrderList(source),
						source
					)
				),
				new FkRegex(
					"/payment-order/view",
					new TkSecure(
						new TkPaymentOrderView(source),
						source
					)
				),
				new FkRegex(
					"/payment-order/edit",
					new TkSecure(
						new TkPaymentOrderEdit(source),
						source
					)
				),
				new FkRegex(
					"/third-party-family",
					new TkSecure(
						new TkTransaction(
							new TkThirdPartyFamilyList(source),
							source
						),
						source
					)
				),
				new FkRegex(
					"/third-party-family/edit",
					new TkSecure(
						new TkThirdPartyFamilyEdit(source),
						source
					)
				),
				new FkRegex(
					"/third-party-family/view",
					new TkSecure(
						new TkThirdPartyFamilyView(source),
						source
					)
				)
			)
		);
	}
}
