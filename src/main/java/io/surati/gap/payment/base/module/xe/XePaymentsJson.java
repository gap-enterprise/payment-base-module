package io.surati.gap.payment.base.module.xe;

import io.surati.gap.commons.utils.convert.FrShortDateFormat;
import io.surati.gap.payment.base.api.Payment;
import org.takes.rs.RsJson;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonArrayBuilder;
import javax.json.JsonStructure;
import java.io.IOException;

public final class XePaymentsJson implements RsJson.Source {

	private final Long count;
	private final Iterable<Payment> items;
	
	public XePaymentsJson(final Iterable<Payment> items, final Long count) {
		this.count = count;
		this.items = items;
	}
	
	@Override
	public JsonStructure toJson() throws IOException {
		return Json.createObjectBuilder()
		   .add("items", toJson(this.items))
           .add("count", this.count)
		   .build();
	}
	
	private static JsonArray toJson(final Iterable<Payment> items) throws IOException {
		JsonArrayBuilder builder = Json.createArrayBuilder();
		for (Payment item : items) {
			builder.add(Json.createObjectBuilder()
				.add("id", item.id())
				.add("date_view", new FrShortDateFormat().convert(item.date()))
                .add("beneficiary", item.beneficiary().name())
                .add("amount_in_human", item.amountInHuman())
                .add("note", item.name())
                .add("status", item.status().toString())
                .add("reference", item.internalReference())
           );
		}
		return builder.build();
	}

}
