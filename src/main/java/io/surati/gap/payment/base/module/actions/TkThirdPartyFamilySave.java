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

import io.surati.gap.payment.base.api.ThirdPartyFamilies;
import io.surati.gap.payment.base.api.ThirdPartyFamily;
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
 * Take that creates an ThirdParty Family.
 *
 * <p>The class is immutable and thread-safe.</p>
 *
 * @since 0.1.0
 */
public final class TkThirdPartyFamilySave implements Take {

	/**
	 * Database
	 */
	private final DataSource source;
	
	/**
	 * Ctor.
	 * @param source DataSource
	 */
	public TkThirdPartyFamilySave(final DataSource source) {
		this.source = source;
	}
	
	@Override
	public Response act(Request req) throws Exception {		
		final RqFormSmart form = new RqFormSmart(new RqGreedy(req));
		final Long id = Long.parseLong(form.single("id", "0"));		
		final String code = form.single("code");
		final String name = form.single("name");
		final ThirdPartyFamilies items = new DbThirdPartyFamilies(this.source);
		final String msg;
		final ThirdPartyFamily item;
		if(id.equals(0L)) {
			item = items.add(code, name);
			msg = String.format("La famille de tiers %s a ??t?? cr???? avec succ??s !", name);
		} else {
			item = items.get(id);
			item.update(code, name);
			msg = String.format("La famille de tiers %s a ??t?? modifi?? avec succ??s !", name);
		}
		return new RsForward(
			new RsFlash(
				msg,
				Level.INFO
			),
			String.format("/third-party-family/view?id=%s", item.id())
		);	
	}
}
