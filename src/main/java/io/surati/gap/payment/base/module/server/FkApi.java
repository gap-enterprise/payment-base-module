package io.surati.gap.payment.base.module.server;

import com.minlessika.db.Database;
import io.surati.gap.payment.base.module.rest.TkPaymentOrderSearch;
import io.surati.gap.payment.base.module.rest.TkPaymentSearch;
import io.surati.gap.payment.base.module.rest.TkReferenceDocumentHistorySearch;
import io.surati.gap.payment.base.module.rest.TkThirdPartySearch;
import io.surati.gap.web.base.TkSecure;
import org.takes.facets.fork.FkChain;
import org.takes.facets.fork.FkRegex;
import org.takes.facets.fork.FkWrap;

/**
 * Front for API.
 *
 * @since 0.1
 */
public final class FkApi extends FkWrap {

	public FkApi(final Database source) {
		super(
			new FkChain(
				new FkRegex(
					"/third-party/search",
					new TkSecure(
						new TkThirdPartySearch(source),
						source
					)
				),
				new FkRegex(
					"/reference-document/history/search",
					new TkSecure(
						new TkReferenceDocumentHistorySearch(source),
						source
					)
				),
				new FkRegex(
					"/payment-order/search",
					new TkSecure(
						new TkPaymentOrderSearch(source),
						source
					)
				),
				new FkRegex(
					"/payment/search",
					new TkSecure(
						new TkPaymentSearch(source),
						source
					)
				)
			)
		);
	}
}
