package io.surati.gap.payment.base.module.xe;

import io.surati.gap.payment.base.api.ThirdParties;
import io.surati.gap.payment.base.api.ThirdParty;
import org.cactoos.iterable.Joined;
import org.cactoos.iterable.Mapped;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

public final class XeThirdParties extends XeWrap {
	
	public XeThirdParties(final ThirdParties thirdParties) {
		this(thirdParties.iterate());
	}
	
	public XeThirdParties(final Iterable<ThirdParty> items) {
		super(
			new XeDirectives(
				new Directives()
					.add("third_parties")
					.append(
						new Joined<>(
							new Mapped<>(
								item -> new XeThirdParty("third_party", item).toXembly(),
								items
							)
						)
					)
			)
		);
	}
}
