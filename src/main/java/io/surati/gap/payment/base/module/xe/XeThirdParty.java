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
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

public final class XeThirdParty extends XeWrap {

	public XeThirdParty(final ThirdParty thirdparty) {
		this("item", thirdparty);
	}
	
	public XeThirdParty(final String name, final ThirdParty thirdparty) {
		super(
			new XeDirectives(
				new Directives()
				.add(name)
					.add("id").set(thirdparty.id()).up()
					.add("code").set(thirdparty.code()).up()
					.add("name").set(thirdparty.name()).up()
					.add("abbreviated").set(thirdparty.abbreviated()).up()
					.add("family").set(thirdparty.family().name()).up()
					.add("family_id").set(thirdparty.family().id()).up()
					.add("payment_deadline").set(thirdparty.paymentCondition().deadline()).up()
				.up()
			)
		);
	}
}
