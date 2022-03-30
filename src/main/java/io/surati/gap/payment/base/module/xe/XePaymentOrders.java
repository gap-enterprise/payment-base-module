package io.surati.gap.payment.base.module.xe;

import io.surati.gap.payment.base.api.PaymentOrder;
import org.cactoos.iterable.Mapped;
import org.cactoos.iterable.Joined;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

public final class XePaymentOrders extends XeWrap {
	
	public XePaymentOrders(final Iterable<PaymentOrder> items) {
		super(
			new XeDirectives(
				new Directives()
					.add("payment_orders")
					.append(
						new Joined<>(
							new Mapped<>(
								item -> new XePaymentOrder("payment_order", item).toXembly(),
								items
							)
						)
					)
			)
		);
	}
}
