package io.surati.gap.payment.base.module;

import io.surati.gap.commons.utils.pf4j.DatabaseSetup;
import io.surati.gap.commons.utils.pf4j.ModuleRegistration;
import io.surati.gap.commons.utils.pf4j.WebFront;
import io.surati.gap.payment.base.db.PaymentBaseDemoDatabase;
import io.surati.gap.payment.base.db.PaymentBaseProdDatabase;
import io.surati.gap.payment.base.module.server.FkActions;
import io.surati.gap.payment.base.module.server.FkApi;
import io.surati.gap.payment.base.module.server.FkPages;
import javax.sql.DataSource;
import org.pf4j.Extension;
import org.pf4j.Plugin;
import org.pf4j.PluginWrapper;
import org.takes.facets.auth.Pass;
import org.takes.facets.fork.FkChain;
import org.takes.facets.fork.Fork;

public final class PaymentBasePlugin extends Plugin {

    public PaymentBasePlugin(final PluginWrapper wrapper) {
        super(wrapper);
    }

    @Override
    public void start() {
        System.out.println("Starting Payment base module...");
    }

    @Override
    public void stop() {
        System.out.println("Stopping Payment base module...");
    }

    @Override
    public void delete() {
        System.out.println("Deleting Payment base module...");
    }

    @Extension
    public static final class PaymentBaseRegistration implements ModuleRegistration {

        @Override
        public void register() {
            PaymentBaseModule.setup();
        }
    }

    @Extension
    public static final class PaymentBaseDatabaseSetup implements DatabaseSetup {

        @Override
        public void migrate(final DataSource src, final boolean demo) {
            if (demo) {
                new PaymentBaseDemoDatabase(src);
            } else {
                new PaymentBaseProdDatabase(src);
            }
        }
    }

    @Extension
    public static final class PaymentBaseWebFront implements WebFront {

        @Override
        public Fork pages() {
            return new FkChain();
        }

        @Override
        public Fork pages(final DataSource src) {
            return new FkChain(
                new FkPages(src),
                new FkApi(src),
                new FkActions(src)
            );
        }

        @Override
        public Fork pages(final DataSource src, final Pass pass) {
            return new FkChain();
        }
    }
}
