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
package io.surati.gap.payment.base.module.pages;

import io.surati.gap.payment.base.api.PaymentOrder;
import io.surati.gap.payment.base.db.DbPaginedPaymentOrders;
import io.surati.gap.payment.base.module.xe.XePaymentOrder;
import io.surati.gap.payment.base.module.server.RsPage;
import io.surati.gap.web.base.xe.XeRootPage;
import org.cactoos.collection.Sticky;
import org.takes.Request;
import org.takes.Response;
import org.takes.Take;
import org.takes.rq.RqHref;
import org.takes.rs.xe.XeAppend;
import org.takes.rs.xe.XeSource;

import javax.sql.DataSource;

/**
 * Take that shows a payment order in read-only mode.
 *
 * <p>The class is immutable and thread-safe.</p>
 *
 * @since 3.0
 */
public final class TkPaymentOrderView implements Take {

	/**
	 * DataSource
	 */
	private final DataSource source;
	
	/**
	 * Ctor.
	 * @param source DataSource
	 */
	public TkPaymentOrderView(final DataSource source) {
		this.source = source;
	}

	@Override
	public Response act(Request req) throws Exception {
		final RqHref.Smart href = new RqHref.Smart(req);
		final Long id = Long.parseLong(href.single("id"));
		final PaymentOrder item = new DbPaginedPaymentOrders(this.source).get(id);
		final XeSource src = new XePaymentOrder(item);
		return new RsPage(
			"/io/surati/gap/payment/base/module/xsl/payment_order/view.xsl",
			req,
			this.source,
			() -> new Sticky<>(
				new XeAppend("menu", "payment-order"),
				new XeRootPage(req),
				src
			)
		);
	}
}
