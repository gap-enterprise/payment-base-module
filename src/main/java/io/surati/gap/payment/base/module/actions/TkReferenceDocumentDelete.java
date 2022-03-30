package io.surati.gap.payment.base.module.actions;

import io.surati.gap.admin.base.api.Log;
import io.surati.gap.payment.base.api.ReferenceDocument;
import io.surati.gap.payment.base.api.ReferenceDocuments;
import io.surati.gap.payment.base.db.DbPaginedReferenceDocuments;
import io.surati.gap.web.base.log.RqLog;
import io.surati.gap.web.base.rq.RootPageUri;
import org.takes.Request;
import org.takes.Response;
import org.takes.Take;
import org.takes.facets.flash.RsFlash;
import org.takes.facets.forward.RsForward;
import org.takes.rq.RqHref;

import javax.sql.DataSource;
import java.util.logging.Level;

public final class TkReferenceDocumentDelete implements Take {
	
	/**
	 * Database
	 */
	private final DataSource source;
	
	/**
	 * Ctor.
	 * @param source DataSource
	 */
	public TkReferenceDocumentDelete(final DataSource source) {
		this.source = source;
	}
	
	@Override
	public Response act(Request req) throws Exception {
		final Log log = new RqLog(this.source, req);
		final Long id = Long.parseLong(new RqHref.Smart(req).single("id"));
		final ReferenceDocuments items = new DbPaginedReferenceDocuments(this.source);
		final ReferenceDocument item = items.get(id);
		log.info("Suppression du document de référence (N°=%s) du Tiers (Code=%s)", item.reference(), item.issuer().code());
		items.remove(item);
		return new RsForward(
			new RsFlash(
				"Le document de référence a été supprimé avec succès !",
				Level.INFO
			),
			new RootPageUri(req).toString()
		);	
	}
}
