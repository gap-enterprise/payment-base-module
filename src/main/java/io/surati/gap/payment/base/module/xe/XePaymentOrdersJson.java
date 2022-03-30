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
package io.surati.gap.payment.base.module.xe;

import io.surati.gap.commons.utils.amount.FrAmountInXof;
import io.surati.gap.commons.utils.convert.FrShortDateFormat;
import io.surati.gap.payment.base.api.PaymentOrder;
import io.surati.gap.payment.base.api.ReferenceDocument;
import org.takes.rs.RsJson;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonArrayBuilder;
import javax.json.JsonStructure;
import java.io.IOException;

public final class XePaymentOrdersJson implements RsJson.Source {

	private final Long count;
	private final Iterable<PaymentOrder> items;
	private final Double totalamount;
	
	public XePaymentOrdersJson(final Iterable<PaymentOrder> items, final Long count, final Double totalamount) {
		this.count = count;
		this.items = items;
		this.totalamount = totalamount;
	}
	
	@Override
	public JsonStructure toJson() throws IOException {
		return Json.createObjectBuilder()
		   .add("items", toJson(this.items))
           .add("count", this.count)
           .add("total_amount", this.totalamount)
           .add("total_amount_in_human", new FrAmountInXof(this.totalamount).toString())
		   .build();
	}
	
	private static JsonArray toJson(final Iterable<PaymentOrder> items) throws IOException {
		JsonArrayBuilder builder = Json.createArrayBuilder();
		for (PaymentOrder item : items) {
			final String refdocdateview;
			final String refdocname;
			if(item.document() == ReferenceDocument.EMPTY) {
				refdocdateview = "Aucune";
				refdocname = "Aucun";
			} else {
				refdocdateview = new FrShortDateFormat().convert(item.document().date());
				refdocname = String.format("%s N°%s", item.document().type().toString(), item.document().reference());
			}
			builder.add(Json.createObjectBuilder()
				.add("id", item.id())
				.add("date_view", new FrShortDateFormat().convert(item.date()))
				.add("ref_doc_date_view", refdocdateview)
				.add("reference", item.reference())
				.add("beneficiary", item.beneficiary().name())
				.add("amount_to_pay", item.amountToPay())
                .add("amount_to_pay_in_human", item.amountToPayInHuman())
                .add("ref_doc_name", refdocname)
                .add("status", item.status().toString())
                .add("abbreviated", item.beneficiary().abbreviated())
                .add("code", item.beneficiary().code())
           );
		}
		return builder.build();
	}
}
