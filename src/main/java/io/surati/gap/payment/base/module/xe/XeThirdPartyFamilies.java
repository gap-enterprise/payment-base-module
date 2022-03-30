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

import io.surati.gap.payment.base.api.ThirdPartyFamilies;
import io.surati.gap.payment.base.api.ThirdPartyFamily;
import org.cactoos.collection.Mapped;
import org.cactoos.iterable.Joined;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

public final class XeThirdPartyFamilies extends XeWrap {

	public XeThirdPartyFamilies(final ThirdPartyFamilies thirdPartyFamilies) {
		this(thirdPartyFamilies.iterate());
	}
	
	public XeThirdPartyFamilies(final Iterable<ThirdPartyFamily> items) {
		super(
			new XeDirectives(
				new Directives()
					.add("third_party_families")
					.append(
						new Joined<>(
							new Mapped<>(
								item -> new XeThirdPartyFamily("third_party_family", item).toXembly(),
								items
							)
						)
					)
			)
		);
	}
}
