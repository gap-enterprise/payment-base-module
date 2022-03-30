package io.surati.gap.payment.base.module.rest;

import io.surati.gap.commons.utils.convert.filter.Comparator;
import io.surati.gap.commons.utils.convert.filter.Filter;
import io.surati.gap.commons.utils.time.Period;
import io.surati.gap.commons.utils.time.SafePeriodFromText;
import io.surati.gap.payment.base.api.ReferenceDocument;
import io.surati.gap.payment.base.api.ReferenceDocumentStatus;
import io.surati.gap.payment.base.api.ReferenceDocuments;
import io.surati.gap.payment.base.db.DbPaginedReferenceDocuments;
import io.surati.gap.payment.base.filter.ReferenceDocumentCriteria;
import io.surati.gap.payment.base.module.xe.XeReferenceDocumentsJson;
import org.takes.Request;
import org.takes.Response;
import org.takes.Take;
import org.takes.rq.RqHref.Smart;
import org.takes.rs.RsJson;

import javax.sql.DataSource;
import java.util.Arrays;

public final class TkReferenceDocumentHistorySearch implements Take {

	/**
	 * Database
	 */
	private final DataSource source;
	
	/**
	 * Ctor.
	 * @param source DataSource
	 */
	public TkReferenceDocumentHistorySearch(final DataSource source) {
		this.source = source;
	}
	
	@Override
	public Response act(Request req) throws Exception {	
		final Smart href = new Smart(req);
		final String filter = href.single("filter", "");					
		final Long page = Long.parseLong(href.single("page"));
		final Long nbperpage = Long.parseLong(href.single("nbperpage"));
		final Period period = new SafePeriodFromText(
			href.single("editbegindate", ""),
			href.single("editenddate", "")
		);
		final ReferenceDocumentStatus status = ReferenceDocumentStatus.valueOf(href.single("statusid", "NONE"));
		final ReferenceDocumentCriteria criteria = new ReferenceDocumentCriteria();
		if(status == ReferenceDocumentStatus.NONE) {
			criteria.add(
				Arrays.asList(
					ReferenceDocumentStatus.WAITING_FOR_PAYMENT,
					ReferenceDocumentStatus.PAID_PARTIALLY,
					ReferenceDocumentStatus.PAID
				)
			);
		} else {
			criteria.add(status);
		}
		criteria.addInterval(ReferenceDocument.DATE, period);
		criteria.addFilter(new Filter(Comparator.CONTAINS, filter));
		final ReferenceDocuments refdocs = new DbPaginedReferenceDocuments(
			this.source,
			nbperpage,
			page,
			criteria
		);
		return new RsJson(
			new XeReferenceDocumentsJson(
				refdocs.iterate(),
				refdocs.count(),
				refdocs.totalAmount(),
				refdocs.amountLeft(),
				0.0
			)
		);
	}

}
