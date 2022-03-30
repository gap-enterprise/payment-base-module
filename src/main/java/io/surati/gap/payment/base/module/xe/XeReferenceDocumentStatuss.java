package io.surati.gap.payment.base.module.xe;

import io.surati.gap.payment.base.api.ReferenceDocumentStatus;
import org.cactoos.iterable.Joined;
import org.cactoos.iterable.Mapped;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

import java.util.Collection;
import java.util.LinkedList;

public final class XeReferenceDocumentStatuss extends XeWrap {

	public XeReferenceDocumentStatuss() {
		this(withoutNone());
	}
	public XeReferenceDocumentStatuss(final Iterable<ReferenceDocumentStatus> items) {
		super(
			new XeDirectives(
				new Directives()
					.add("reference_document_statuss")
					.append(
						new Joined<>(
							new Mapped<>(
								item -> new XeReferenceDocumentStatus("reference_document_status", item).toXembly(),
								items
							)
						)
					)
			)
		);
	}
	
	private final static Iterable<ReferenceDocumentStatus> withoutNone() {
		final Collection<ReferenceDocumentStatus> status = new LinkedList<>();
		for (ReferenceDocumentStatus st : ReferenceDocumentStatus.values()) {
			if(st != ReferenceDocumentStatus.NONE) {
				status.add(st);
			}
		}
		return status;
	}
}
