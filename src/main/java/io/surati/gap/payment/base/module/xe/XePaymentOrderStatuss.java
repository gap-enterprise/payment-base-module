package io.surati.gap.payment.base.module.xe;

import io.surati.gap.payment.base.api.PaymentOrderStatus;
import org.cactoos.collection.Mapped;
import org.cactoos.iterable.Joined;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directive;
import org.xembly.Directives;

import java.util.Collection;
import java.util.LinkedList;

public final class XePaymentOrderStatuss extends XeWrap {

	public XePaymentOrderStatuss() {
		this(withoutNone());
	}
	public XePaymentOrderStatuss(final Iterable<PaymentOrderStatus> items) {
		super(
			new XeDirectives(
				new Directives()
					.add("payment_order_statuss")
					.append(
						new Joined<>(
							new Mapped<PaymentOrderStatus, Iterable<Directive>>(
								item -> new XePaymentOrderStatus("payment_order_status", item).toXembly(),
								items
							)
						)
					)
			)
		);
	}
	
	private final static Iterable<PaymentOrderStatus> withoutNone() {
		final Collection<PaymentOrderStatus> status = new LinkedList<>();
		for (PaymentOrderStatus st : PaymentOrderStatus.values()) {
			if(st != PaymentOrderStatus.NONE) {
				status.add(st);
			}
		}
		return status;
	}
}
