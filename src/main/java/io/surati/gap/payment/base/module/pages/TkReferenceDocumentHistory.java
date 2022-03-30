package io.surati.gap.payment.base.module.pages;

import io.surati.gap.payment.base.module.xe.XeReferenceDocumentStatuss;
import io.surati.gap.web.base.RsPage;
import io.surati.gap.web.base.xe.XeRootPage;
import org.cactoos.collection.Sticky;
import org.takes.Request;
import org.takes.Response;
import org.takes.Take;
import org.takes.rs.xe.XeAppend;
import org.takes.rs.xe.XeSource;

import javax.sql.DataSource;

public final class TkReferenceDocumentHistory implements Take {
	
	private final DataSource source;

	/**
	 * Ctor.
	 * @param source DataSource
	 */
	public TkReferenceDocumentHistory(final DataSource source) {
		this.source = source;
	}
	
	@Override
	public Response act(Request req) throws Exception {
		final XeSource src = new XeReferenceDocumentStatuss();
		return new RsPage(
			"/io/surati/gap/payment/base/module/xsl/reference_document/history.xsl",
			req,
			this.source,
			() -> new Sticky<>(
				new XeAppend("menu", "reference-document"),
				new XeRootPage(
					"Historique",
					"Documents de référence",
					req
				),
				src
			)
		);
	}

}
