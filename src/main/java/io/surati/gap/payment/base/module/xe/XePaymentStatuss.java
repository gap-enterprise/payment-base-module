package io.surati.gap.payment.base.module.xe;

import io.surati.gap.payment.base.api.PaymentStatus;
import org.cactoos.collection.Mapped;
import org.cactoos.iterable.Joined;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directive;
import org.xembly.Directives;

import java.util.Collection;
import java.util.LinkedList;

public final class XePaymentStatuss extends XeWrap {

	public XePaymentStatuss() {
		this(withoutNone());
	}
	public XePaymentStatuss(final Iterable<PaymentStatus> items) {
		super(
			new XeDirectives(
				new Directives()
					.add("bank_note_statuss")
					.append(
						new Joined<>(
							new Mapped<PaymentStatus, Iterable<Directive>>(
								item -> new XePaymentStatus("bank_note_status", item).toXembly(),
								items
							)
						)
					)
			)
		);
	}
	
	private final static Iterable<PaymentStatus> withoutNone() {
		final Collection<PaymentStatus> status = new LinkedList<>();
		for (PaymentStatus st : PaymentStatus.values()) {
			if(st != PaymentStatus.NONE) {
				status.add(st);
			}
		}
		return status;
	}
}
