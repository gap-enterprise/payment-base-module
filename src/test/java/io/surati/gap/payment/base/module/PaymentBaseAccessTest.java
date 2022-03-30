package io.surati.gap.payment.base.module;

import io.surati.gap.admin.base.api.Access;
import io.surati.gap.payment.base.module.PaymentBaseAccess;
import org.hamcrest.MatcherAssert;
import org.hamcrest.Matchers;
import org.junit.jupiter.api.Test;

/**
 * Test case for {@link PaymentBaseAccess}.
 *
 * @since 0.1
 */
final class PaymentBaseAccessTest {

    @Test
    void containsRight() {
        MatcherAssert.assertThat(
            Access.VALUES,
            Matchers.hasItem(PaymentBaseAccess.VISUALISER_PAIEMENTS)
        );
    }
}
