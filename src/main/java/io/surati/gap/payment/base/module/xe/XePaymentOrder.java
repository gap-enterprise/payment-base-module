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
import org.apache.commons.lang.StringUtils;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * Xml Payment order.
 *
 * @since 3.0
 */
public final class XePaymentOrder extends XeWrap {

	public XePaymentOrder(final PaymentOrder order) {
		this("item", order);
	}

	public XePaymentOrder(final String name, final PaymentOrder order) {
		super(XePaymentOrder.convert(name, order));
	}
	
	private static XeDirectives convert(final String name, final PaymentOrder order) {
		final DecimalFormat df = new DecimalFormat("#.#");
		final Directives dirs = new Directives()
				.add(name)
				.add("id").set(order.id()).up()
				.add("date").set(order.date().format(DateTimeFormatter.ISO_DATE)).up()
				.add("reference").set(order.reference()).up()
				.add("date_view").set(new FrShortDateFormat().convert(order.date())).up()
				.add("beneficiary_id").set(order.beneficiary().id()).up()
				.add("beneficiary").set(order.beneficiary().abbreviated()).up()
				.add("amount_to_pay_in_human").set(order.amountToPayInHuman()).up()
				.add("amount_to_pay").set(df.format(order.amountToPay())).up()
				.add("authorizing_officer_id").set(order.authorizingOfficer().id()).up()
				.add("authorizing_officer").set(order.authorizingOfficer().name()).up()
				.add("author_id").set(order.author().id()).up()
				.add("author").set(order.author().name()).up()
				.add("status_id").set(order.status().name()).up()
				.add("status").set(order.status().toString()).up()
				.add("reason").set(order.reason()).up()
				.add("description").set(StringUtils.isBlank(order.description()) ? "Aucune" : order.description()).up();
		final ReferenceDocument doc = order.document();
		if(doc != ReferenceDocument.EMPTY) {
			dirs
			.add("ref_doc_id").set(doc.id()).up()
			.add("ref_doc_type_id").set(doc.type().name()).up()
			.add("ref_doc_type").set(doc.type().toString()).up()
			.add("ref_doc_reference").set(doc.reference()).up()
			.add("ref_doc_date_view").set(new FrShortDateFormat().convert(doc.date())).up()
			.add("ref_doc_date").set(doc.date().format(DateTimeFormatter.ISO_DATE)).up()
			.add("ref_doc_name").set(String.format("%s N°%s", doc.type().toString(), doc.reference())).up()
			.add("ref_doc_object").set(doc.object()).up()
			.add("ref_doc_place").set(doc.place()).up()
			.add("ref_doc_deposit_date_view").set(doc.depositDate() == LocalDate.MIN ? "Aucune date" : new FrShortDateFormat().convert(doc.depositDate())).up()
			.add("ref_doc_deposit_date").set(doc.depositDate() == LocalDate.MIN ? StringUtils.EMPTY : doc.depositDate().format(DateTimeFormatter.ISO_DATE)).up()
			.add("ref_doc_entry_date_view").set(doc.entryDate() == LocalDate.MIN ? "Aucune date" : new FrShortDateFormat().convert(doc.entryDate())).up()
			.add("ref_doc_entry_date").set(doc.entryDate() == LocalDate.MIN ? StringUtils.EMPTY : doc.entryDate().format(DateTimeFormatter.ISO_DATE)).up()
			.add("ref_doc_amount_in_human").set(new FrAmountInXof(doc.amount())).up()
			.add("ref_doc_amount").set(df.format(doc.amount())).up();
		}
		dirs.up();
		return new XeDirectives(dirs);
	}
}
