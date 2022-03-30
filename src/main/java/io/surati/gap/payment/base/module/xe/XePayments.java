package io.surati.gap.payment.base.module.xe;

import io.surati.gap.payment.base.api.Payment;
import org.cactoos.collection.Mapped;
import org.cactoos.iterable.Joined;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

public final class XePayments extends XeWrap {

	public XePayments(final Iterable<Payment> items) {
		super(
			new XeDirectives(
				new Directives()
					.add("payments")
					.append(
						new Joined<>(
							new Mapped<>(
								item -> new XePayment("payment", item).toXembly(),
								items
							)
						)
					)
			)
		);
	}
}
