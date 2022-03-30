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
package io.surati.gap.payment.base.module.rest;

import io.surati.gap.commons.utils.time.Period;
import io.surati.gap.commons.utils.time.SafePeriodFromText;
import io.surati.gap.payment.base.api.PaymentOrderStatus;
import io.surati.gap.payment.base.api.PaymentOrders;
import io.surati.gap.payment.base.db.DbPaginedPaymentOrders;
import io.surati.gap.payment.base.module.xe.XePaymentOrdersJson;
import org.takes.Request;
import org.takes.Response;
import org.takes.Take;
import org.takes.rq.RqHref.Smart;
import org.takes.rs.RsJson;

import javax.sql.DataSource;

public final class TkPaymentOrderSearch implements Take {

	/**
	 * Database
	 */
	private final DataSource source;
	
	/**
	 * Ctor.
	 * @param source DataSource
	 */
	public TkPaymentOrderSearch(final DataSource source) {
		this.source = source;
	}
	
	@Override
	public Response act(Request req) throws Exception {	
		final Smart href = new Smart(req);
		final String filter = href.single("filter", "");					
		final Long page = Long.parseLong(href.single("page"));
		final Long nbperpage = Long.parseLong(href.single("nbperpage"));
		final Period opperiod = new SafePeriodFromText(
			href.single("opbegindate", ""),
			href.single("openddate", "")
		);
		final Period refdocperiod = new SafePeriodFromText(
			href.single("refdocbegindate", ""),
			href.single("refdocenddate", "")
		);
		final PaymentOrderStatus status = PaymentOrderStatus.valueOf(href.single("statusid", "NONE"));
		final PaymentOrders payments = new DbPaginedPaymentOrders(
			this.source,
			nbperpage,
			page,
			filter,
			opperiod,
			refdocperiod,
			status
		);
		return new RsJson(
			new XePaymentOrdersJson(payments.iterate(), payments.count(), payments.totalAmount())
		);
	}

}
