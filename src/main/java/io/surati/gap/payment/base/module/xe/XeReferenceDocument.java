package io.surati.gap.payment.base.module.xe;

import io.surati.gap.commons.utils.amount.FrAmountInXof;
import io.surati.gap.commons.utils.amount.FrWYSIWYGAmount;
import io.surati.gap.commons.utils.convert.FrShortDateFormat;
import io.surati.gap.payment.base.api.ReferenceDocument;
import org.apache.commons.lang.StringUtils;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public final class XeReferenceDocument extends XeWrap {

	public XeReferenceDocument(final ReferenceDocument refdoc) {
		this("item", refdoc);
	}
	
	public XeReferenceDocument(final String name, final ReferenceDocument item) {
		super(
			new XeDirectives(
				new Directives()
				.add(name)
					.add("id").set(item.id()).up()
					.add("name").set(String.format("%s N°%s", item.type().toString(), item.reference())).up()
					.add("amount").set(new FrWYSIWYGAmount(item.amount())).up()
					.add("amount_in_human").set(new FrAmountInXof(item.amount())).up()
					.add("amount_left").set(new FrWYSIWYGAmount(item.amountLeft())).up()
					.add("amount_paid").set(new FrWYSIWYGAmount(item.amountPaid())).up()
					.add("amount_left_in_human").set(new FrAmountInXof(item.amountLeft())).up()
					.add("amount_paid_in_human").set(new FrAmountInXof(item.amountPaid())).up()
					.add("date").set(item.date().format(DateTimeFormatter.ISO_DATE)).up()
					.add("date_view").set(new FrShortDateFormat().convert(item.date())).up()
					.add("deposit_date_view").set(item.depositDate() == LocalDate.MIN ? "Aucune date" : new FrShortDateFormat().convert(item.depositDate())).up()
					.add("deposit_date").set(item.depositDate() == LocalDate.MIN ? StringUtils.EMPTY : item.depositDate().format(DateTimeFormatter.ISO_DATE)).up()
					.add("entry_date_view").set(item.entryDate() == LocalDate.MIN ? "Aucune date" : new FrShortDateFormat().convert(item.entryDate())).up()
					.add("entry_date").set(item.entryDate() == LocalDate.MIN ? StringUtils.EMPTY : item.entryDate().format(DateTimeFormatter.ISO_DATE)).up()
					.add("reference").set(item.reference()).up()
					.add("object").set(item.object()).up()
					.add("place").set(item.place()).up()
					.add("status").set(item.status().toString()).up()
					.add("status_id").set(item.status().name()).up()
					.add("step").set(item.step().toString()).up()
					.add("step_id").set(item.step().name()).up()
					.add("type").set(item.type().toString()).up()
					.add("type_id").set(item.type().name()).up()
					.add("abbreviated").set(item.issuer().abbreviated()).up()
					.add("beneficiary").set(item.issuer().name()).up()
					.add("code").set(item.issuer().code()).up()
					.add("beneficiary_id").set(item.issuer().id()).up()
				.up()
			)
		);
	}
}
