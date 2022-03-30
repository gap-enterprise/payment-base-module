package io.surati.gap.payment.base.module.xe;

import io.surati.gap.payment.base.api.ReferenceDocument;
import io.surati.gap.payment.base.api.ReferenceDocuments;
import org.cactoos.collection.Mapped;
import org.cactoos.iterable.Joined;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

public final class XeReferenceDocuments extends XeWrap {
	
	public XeReferenceDocuments(final ReferenceDocuments refdocs) {
		this(refdocs.iterate());
	}
	
	public XeReferenceDocuments(final Iterable<ReferenceDocument> items) {
		super(
			new XeDirectives(
				new Directives()
					.add("ref_docs")
					.append(
						new Joined<>(
							new Mapped<>(
								item -> new XeReferenceDocument("ref_doc", item).toXembly(),
								items
							)
						)
					)
			)
		);
	}
}
