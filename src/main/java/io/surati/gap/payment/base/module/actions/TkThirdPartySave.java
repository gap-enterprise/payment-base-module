/**
MIT License

Copyright (c) 2021 Surati

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */  
package io.surati.gap.payment.base.module.actions;

import io.surati.gap.payment.base.api.ThirdParties;
import io.surati.gap.payment.base.api.ThirdParty;
import io.surati.gap.payment.base.api.ThirdPartyFamily;
import io.surati.gap.payment.base.db.DbThirdParties;
import io.surati.gap.payment.base.db.DbThirdPartyFamilies;
import org.takes.Request;
import org.takes.Response;
import org.takes.Take;
import org.takes.facets.flash.RsFlash;
import org.takes.facets.forward.RsForward;
import org.takes.rq.RqGreedy;
import org.takes.rq.form.RqFormSmart;

import javax.sql.DataSource;
import java.util.logging.Level;

/**
 * Take that creates an ThirdParty.
 *
 * <p>The class is immutable and thread-safe.</p>
 *
 * @since 0.1.0
 */


public final class TkThirdPartySave implements Take {

	/**
	 * Database
	 */
	private final DataSource source;
	
	/**
	 * Ctor.
	 * @param source DataSource
	 */
	public TkThirdPartySave(final DataSource source) {
		this.source = source;
	}
	
	@Override
	public Response act(Request req) throws Exception {		
		final RqFormSmart form = new RqFormSmart(new RqGreedy(req));
		final Long id = Long.parseLong(form.single("id", "0"));		
		final String code = form.single("code");
		final String name = form.single("name");
		final String abbreviated = form.single("abbreviated");
		final int paymentdeadline = Integer.parseInt(form.single("payment_deadline"));
		final ThirdParties items = new DbThirdParties(this.source);
		final Long familyid = Long.parseLong(form.single("family_id"));
		final String msg;
		final ThirdParty item;
		
		if(id.equals(0L)) {
			item = items.add(code, name, abbreviated);
			msg = String.format("Le tiers %s a été créé avec succès !", name);
		} else {
			item = items.get(id);
			item.update(code, name, abbreviated);
			msg = String.format("Le tiers %s a été modifié avec succès !", name);
		}
		item.paymentCondition().update(paymentdeadline);
		if(familyid.equals(0L)) {
			item.assign(ThirdPartyFamily.EMPTY);
		} else {
			final ThirdPartyFamily family = new DbThirdPartyFamilies(this.source).get(familyid);
			item.assign(family);
		}
		
		return new RsForward(
			new RsFlash(
				msg,
				Level.INFO
			),
			String.format("/third-party/view?id=%s", item.id())
		);	
	}
}
