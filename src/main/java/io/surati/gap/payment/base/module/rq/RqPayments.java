package io.surati.gap.payment.base.module.rq;

import io.surati.gap.commons.utils.time.Period;
import io.surati.gap.commons.utils.time.SafePeriodFromText;
import io.surati.gap.payment.base.api.Payment;
import io.surati.gap.payment.base.api.PaymentStatus;
import io.surati.gap.payment.base.api.Payments;
import io.surati.gap.payment.base.db.DbPaginedPayments;
import java.io.IOException;
import javax.sql.DataSource;
import org.takes.Request;
import org.takes.rq.RqHref.Smart;

public final class RqPayments implements Payments {

	private final Payments origin;
	
	public RqPayments(final DataSource source, final Request req) throws IOException {
		final Smart href = new Smart(req);
		final String filter = href.single("filter", "");					
		final Long page = Long.parseLong(href.single("page"));
		final Long nbperpage = Long.parseLong(href.single("nbperpage"));
		final Period payperiod = new SafePeriodFromText(
			href.single("begindate", ""),
			href.single("enddate", "")
		);
		final PaymentStatus status = PaymentStatus.valueOf(href.single("statusid", "NONE"));
		this.origin = new DbPaginedPayments(
		    source,
			nbperpage,
			page,
			filter,
			payperiod,
			status
		);
	}

	@Override
	public Iterable<Payment> iterate() {
		return this.origin.iterate();
	}

	@Override
	public Iterable<Payment> iterate(final PaymentStatus status) {
		return this.origin.iterate(status);
	}

	@Override
	public Payment get(final Long id) {
		return this.origin.get(id);
	}

	@Override
	public Long count() {
		return this.origin.count();
	}

}
