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

import com.minlessika.map.CleanMap;
import io.surati.gap.commons.utils.convert.FrShortDateFormat;
import io.surati.gap.payment.base.api.Payment;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Xml Payment.
 *
 * @since 0.1
 */
public final class XePayment extends XeWrap {

	public XePayment(final Payment note) {
		this("item", note);
	}

	public XePayment(final String name, final Payment item) {
		super(
			new XeDirectives(
				new Directives()
				.add(name)
				.add(
					new CleanMap<>()
						.add("id", item.id())
						.add("date", item.date().format(DateTimeFormatter.ISO_DATE))
						.add("date_view", new FrShortDateFormat().convert(item.date()))
						.add("note_id", item.id())
						.add("note", item.name())
						.add("reference", item.internalReference())
						.add("number", item.issuerReference())
						.add("amount", item.amount().toString())
						.add("amount_in_human", item.amountInHuman())
						.add("amount_in_letters", item.amountInLetters())
						.add("issuer_id", item.issuer().id())
						.add("issuer", item.issuer().name())
						.add("status_id", item.status().name())
						.add("status", item.status().toString())
						.add("beneficiary", item.beneficiary().name())
						.add("beneficiary_id", item.beneficiary().id())
						.add("place", item.place())
						.add("cancel_reason", item.reasonOfCancel())
						.add("mean_type", item.meanType().toString())
						.add("mean_type_id", item.meanType().name())
						.add("group_id", item.orders().id())
						.add("cancel_date", item.cancelDate() == LocalDateTime.MIN ? null : item.cancelDate().format(DateTimeFormatter.ISO_DATE_TIME))
						.add("cancel_date_view", item.cancelDate() == LocalDateTime.MIN ? null : new FrShortDateFormat().convert(item.cancelDate()))
				)
				.up()
			)
		);
	}
}
