package io.surati.gap.payment.base.module.actions;

import io.surati.gap.admin.base.api.Log;
import io.surati.gap.admin.base.api.ReferenceDocumentType;
import io.surati.gap.admin.base.api.User;
import io.surati.gap.payment.base.api.ReferenceDocument;
import io.surati.gap.payment.base.api.ReferenceDocumentStatus;
import io.surati.gap.payment.base.api.ThirdParties;
import io.surati.gap.payment.base.api.ThirdParty;
import io.surati.gap.payment.base.api.ThirdPartyReferenceDocuments;
import io.surati.gap.payment.base.db.DbPaginedReferenceDocuments;
import io.surati.gap.payment.base.db.DbThirdParties;
import io.surati.gap.payment.base.db.DbThirdPartyReferenceDocuments;
import io.surati.gap.web.base.log.RqLog;
import io.surati.gap.web.base.rq.RootPageFull;
import io.surati.gap.web.base.rq.RqUser;
import org.takes.Request;
import org.takes.Response;
import org.takes.Take;
import org.takes.facets.flash.RsFlash;
import org.takes.facets.forward.RsForward;
import org.takes.rq.RqGreedy;
import org.takes.rq.form.RqFormSmart;

import javax.sql.DataSource;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;

public final class TkReferenceDocumentSave implements Take {

	/**
	 * Database
	 */
	private final DataSource source;
	
	/**
	 * Ctor.
	 * @param source DataSource
	 */
	public TkReferenceDocumentSave(final DataSource source) {
		this.source = source;
	}
	
	@Override
	public Response act(Request req) throws Exception {
		final Log log = new RqLog(this.source, req);
		final RqFormSmart form = new RqFormSmart(new RqGreedy(req));
		final Long id = Long.parseLong(form.single("id", "0"));
		final Long beneficiaryid = Long.parseLong(form.single("beneficiary_id"));
		final ThirdParties tps = new DbThirdParties(this.source);
		final ThirdParty tp = tps.get(beneficiaryid);
		final ReferenceDocumentType type = ReferenceDocumentType.valueOf(form.single("type_id"));
		final double amount = Double.parseDouble(form.single("amount"));
		final double advamount = Double.parseDouble(form.single("advanced_amount"));
		final LocalDate docdate = LocalDate.parse(form.single("date"));
		final String reference = form.single("reference");
		final String docplace = form.single("place");
		final String docobject = form.single("object");
		LocalDate date;
		try {
			date = LocalDate.parse(
				form.single("date"),
				DateTimeFormatter.ofPattern("yyyy-MM-dd")
			);
		} catch(Exception ex) {
			throw new IllegalArgumentException("Date d'édition : le format de la date n'est pas correcte !");
		}
		LocalDate docdepositdate;
		try {
			docdepositdate = LocalDate.parse(
				form.single("deposit_date", ""),
				DateTimeFormatter.ofPattern("yyyy-MM-dd")
			);
		} catch(Exception ex) {
			docdepositdate = LocalDate.MIN;
		}
		LocalDate docentrydate;
		try {
			docentrydate = LocalDate.parse(
				form.single("entry_date", ""),
				DateTimeFormatter.ofPattern("yyyy-MM-dd")
			);
		} catch(Exception ex) {
			docentrydate = LocalDate.MIN;
		}
		final User user = new RqUser(this.source, req);
		final ReferenceDocument item;
		final String msg;
		if(id.equals(0L)) {
			final ThirdPartyReferenceDocuments documents = new DbThirdPartyReferenceDocuments(this.source, tp);
			item = documents.add(date, type, reference, amount, docobject, docplace, user);
			msg = "Le document de référence a été créé avec succès !";
			log.info("Ajout du document de référence (N°=%s) du tiers (Code=%s)", item.reference(), item.issuer().code());
		} else {
			item = new DbPaginedReferenceDocuments(this.source).get(id);
			item.update(docdate, reference, docobject, docplace);
			item.amount(amount, advamount);
			item.update(docdepositdate, docentrydate);
			item.type(type);
			msg = "Le document de référence a été modifié avec succès !";
			log.info("Mise à jour du document de référence (N°=%s) du tiers (Code=%s)", item.reference(), item.issuer().code());
		}
		if(item.status() == ReferenceDocumentStatus.WAITING_FOR_PAYMENT) {
			item.type(type);
			item.beneficiary(tp);
		}
		return new RsForward(
			new RsFlash(
				msg,
				Level.INFO
			),
			String.format("/reference-document/view?id=%s&%s", item.id(), new RootPageFull(req))
		);	
	}
}
