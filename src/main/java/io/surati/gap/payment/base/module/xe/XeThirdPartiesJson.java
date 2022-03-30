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

import io.surati.gap.payment.base.api.ThirdParty;
import org.takes.rs.RsJson;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonArrayBuilder;
import javax.json.JsonStructure;
import java.io.IOException;

public final class XeThirdPartiesJson implements RsJson.Source {

	private final Long count;
	private final Iterable<ThirdParty> items;
	
	public XeThirdPartiesJson(final Iterable<ThirdParty> items, final Long count) {
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
	
	private static JsonArray toJson(final Iterable<ThirdParty> items) throws IOException {
		JsonArrayBuilder builder = Json.createArrayBuilder();
		for (ThirdParty item : items) {
			builder.add(Json.createObjectBuilder()
				.add("id", item.id())
				.add("code", item.code())
				.add("name", item.name())
				.add("abbreviated", item.abbreviated())
                .add("family", item.family().name())
                .add("family_id", item.family().id())
           );
		}
		return builder.build();
	}
}
