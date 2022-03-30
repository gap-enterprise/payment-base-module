package io.surati.gap.payment.base.module.xe;

import io.surati.gap.admin.base.api.ReferenceDocumentType;
import org.cactoos.iterable.IterableOf;
import org.cactoos.iterable.Joined;
import org.cactoos.iterable.Mapped;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

import java.util.Arrays;
import java.util.stream.Collectors;

public final class XeReferenceDocumentTypes extends XeWrap {

	public XeReferenceDocumentTypes() {
		this(
			new IterableOf<>(
				Arrays.stream(ReferenceDocumentType.values())
					.filter(c -> c != ReferenceDocumentType.NONE)
					.collect(Collectors.toList())
			)
		);
	}
	public XeReferenceDocumentTypes(final Iterable<ReferenceDocumentType> items) {
		super(
			new XeDirectives(
				new Directives()
					.add("reference_document_types")
					.append(
						new Joined<>(
							new Mapped<>(
								item -> new XeReferenceDocumentType("reference_document_type", item).toXembly(),
								items
							)
						)
					)
			)
		);
	}
}
