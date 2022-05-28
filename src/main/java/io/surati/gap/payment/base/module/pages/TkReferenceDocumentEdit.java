package io.surati.gap.payment.base.module.pages;

import io.surati.gap.admin.base.prop.PropCompany;
import io.surati.gap.payment.base.api.ReferenceDocument;
import io.surati.gap.payment.base.db.DbReferenceDocument;
import io.surati.gap.payment.base.db.DbThirdParties;
import io.surati.gap.payment.base.module.xe.XeReferenceDocument;
import io.surati.gap.payment.base.module.xe.XeReferenceDocumentTypes;
import io.surati.gap.payment.base.module.xe.XeThirdParties;
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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public final class TkReferenceDocumentEdit implements Take {

	/**
	 * DataSource
	 */
	private final DataSource source;
	
	/**
	 * Ctor.
	 * @param source DataSource
	 */
	public TkReferenceDocumentEdit(final DataSource source) {
		this.source = source;
	}

	@Override
	public Response act(Request req) throws Exception {
		final Long id = Long.parseLong(new RqHref.Smart(req).single("id", "0"));	
		final XeSource xecommon = new XeChain(
			new XeReferenceDocumentTypes(),
			new XeAppend("default_reference_document_type_id", new PropCompany().parameter(PropCompany.DEFAULT_REFERENCE_DOCUMENT_TYPE)),
			new XeThirdParties(new DbThirdParties(this.source))
		);
		final XeSource src;
		if(id.equals(0L)) {
			src = new XeChain(
				new XeAppend("today",
			    LocalDate.now().format(DateTimeFormatter.ISO_DATE)),
				xecommon
			);
		} else {
			final ReferenceDocument item = new DbReferenceDocument(this.source, id);
			src = new XeChain(
			    xecommon,
				new XeReferenceDocument(item)
			);
		}
		return new RsPage(
			"/io/surati/gap/payment/base/module/xsl/reference_document/edit.xsl",
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
