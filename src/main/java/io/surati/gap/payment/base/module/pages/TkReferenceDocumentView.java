package io.surati.gap.payment.base.module.pages;

import io.surati.gap.payment.base.api.ReferenceDocument;
import io.surati.gap.payment.base.db.DbReferenceDocument;
import io.surati.gap.payment.base.module.xe.XePayments;
import io.surati.gap.payment.base.module.xe.XeReferenceDocument;
import io.surati.gap.payment.base.module.server.RsPage;
import io.surati.gap.web.base.xe.XeRootPage;
import org.cactoos.collection.Sticky;
import org.takes.Request;
import org.takes.Response;
import org.takes.Take;
import org.takes.rq.RqHref;
import org.takes.rs.xe.XeAppend;
import org.takes.rs.xe.XeChain;
import org.takes.rs.xe.XeSource;

import javax.sql.DataSource;

public final class TkReferenceDocumentView implements Take {

	/**
	 * DataSource
	 */
	private final DataSource source;
	
	/**
	 * Ctor.
	 * @param source DataSource
	 */
	public TkReferenceDocumentView(final DataSource source) {
		this.source = source;
	}

	@Override
	public Response act(Request req) throws Exception {
		final Long id = Long.parseLong(new RqHref.Smart(req).single("id"));
		final ReferenceDocument item = new DbReferenceDocument(this.source, id);
		final XeSource src = new XeChain(
			new XeReferenceDocument(item),
			new XePayments(item.payments()),
			new XeRootPage(
				"current_page",
				"Historique",
				String.format("Document de référence N°%s", item.reference()),
				req
			)
		);
		return new RsPage(
			"/io/surati/gap/payment/base/module/xsl/reference_document/view.xsl",
			req,
			this.source,
			() -> new Sticky<>(
				new XeAppend("menu", "reference-document"),
				src,
				new XeRootPage(req)
			)
		);
	}

}
