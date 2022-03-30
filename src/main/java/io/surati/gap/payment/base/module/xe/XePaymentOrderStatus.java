package io.surati.gap.payment.base.module.xe;

import io.surati.gap.payment.base.api.PaymentOrderStatus;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

public final class XePaymentOrderStatus extends XeWrap {

	public XePaymentOrderStatus(final PaymentOrderStatus status) {
		this("payment_order_status", status);
	}

	public XePaymentOrderStatus(final String name, final PaymentOrderStatus status) {
		super(
			new XeDirectives(
				new Directives()
				.add(name)
					.add("id").set(status.name()).up()
					.add("name").set(status.toString()).up()
				.up()
			)
		);
	}
}