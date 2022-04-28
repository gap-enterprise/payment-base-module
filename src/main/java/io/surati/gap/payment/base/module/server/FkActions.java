package io.surati.gap.payment.base.module.server;

import io.surati.gap.payment.base.module.actions.TkReferenceDocumentDelete;
import io.surati.gap.payment.base.module.actions.TkReferenceDocumentSave;
import io.surati.gap.payment.base.module.actions.TkThirdPartyDelete;
import io.surati.gap.payment.base.module.actions.TkThirdPartyFamilyDelete;
import io.surati.gap.payment.base.module.actions.TkThirdPartyFamilySave;
import io.surati.gap.payment.base.module.actions.TkThirdPartySave;
import io.surati.gap.payment.base.module.pages.TkReferenceDocumentHistory;
import io.surati.gap.web.base.TkSecure;
import javax.sql.DataSource;
import org.takes.facets.fork.FkChain;
import org.takes.facets.fork.FkRegex;
import org.takes.facets.fork.FkWrap;

/**
 * Front for actions.
 *
 * @since 0.1
 */
public final class FkActions extends FkWrap {

	public FkActions(final DataSource source) {
		super(
			new FkChain(
				new FkRegex(
					"/third-party/save",
					new TkSecure(
						new TkThirdPartySave(source),
						source
					)
				),
				new FkRegex(
					"/third-party/delete",
					new TkSecure(
						new TkThirdPartyDelete(source),
						source
					)
				),
				new FkRegex(
					"/third-party-family/save",
					new TkSecure(
						new TkThirdPartyFamilySave(source),
						source
					)
				),
				new FkRegex(
					"/third-party-family/delete",
					new TkSecure(
						new TkThirdPartyFamilyDelete(source),
						source
					)
				),
				new FkRegex(
					"/reference-document/history",
					new TkSecure(
						new TkReferenceDocumentHistory(source),
						source
					)
				),
				new FkRegex(
					"/reference-document/delete",
					new TkSecure(
						new TkReferenceDocumentDelete(source),
						source
					)
				),
				new FkRegex(
					"/reference-document/save",
					new TkSecure(
						new TkReferenceDocumentSave(source),
						source
					)
				)
			)
		);
	}
}
