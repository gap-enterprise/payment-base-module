package io.surati.gap.payment.base.module.xe;

import io.surati.gap.payment.base.api.ReferenceDocumentStatus;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

public final class XeReferenceDocumentStatus extends XeWrap {

	public XeReferenceDocumentStatus(final ReferenceDocumentStatus status) {
		this("reference_document_status", status);
	}

	public XeReferenceDocumentStatus(final String name, final ReferenceDocumentStatus status) {
		super(
			new XeDirectives(
				new Directives()
				.add(name)
					.add("id").set(status.name()).up()
					.add("name").set(status.toString()).up()
				.up()
			)
		);
	}
}