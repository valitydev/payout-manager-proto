include "base.thrift"

namespace java com.rbkmoney.payout.manager.domain
namespace erlang payout_manager_domain

typedef base.ID PartyID
typedef base.ID ShopID
typedef base.ID PayoutToolID
typedef i64 AccountID

/** Сумма в минимальных денежных единицах. */
typedef i64 Amount

/** Денежные средства, состоящие из суммы и валюты. */
struct Cash {
    1: required Amount amount
    2: required CurrencyRef currency
}

struct CurrencyRef {
  1: required CurrencySymbolicCode symbolic_code
}

/** Символьный код, уникально идентифицирующий валюту. */
typedef string CurrencySymbolicCode

/** Полностью вычисленный граф финансовых потоков с проводками всех участников. */
typedef list<FinalCashFlowPosting> FinalCashFlow

/** Вычисленный денежный поток между двумя участниками. */
struct FinalCashFlowPosting {
    1: required FinalCashFlowAccount source
    2: required FinalCashFlowAccount destination
    3: required Cash volume
    4: optional string details
}

struct FinalCashFlowAccount {
    1: required CashFlowAccount account_type
    2: required AccountID account_id
}

/** Счёт в графе финансовых потоков. */
union CashFlowAccount {
    1: MerchantCashFlowAccount merchant
    2: ProviderCashFlowAccount provider
    3: SystemCashFlowAccount system
    4: ExternalCashFlowAccount external
    5: WalletCashFlowAccount wallet
}

enum MerchantCashFlowAccount {

    /**
     * Расчётный счёт:
     *  - учёт прибыли по платежам в магазине;
     *  - учёт возмещённых вознаграждений.
     */
    settlement

    /**
     * Счёт гарантийного депозита:
     *  - учёт средств для погашения реализовавшихся рисков по мерчанту.
     */
    guarantee

    /**
         * Счёт выплаченных средств:
         *  - учёт средств выплаченных мерчанту.
         */
    payout

}

enum ProviderCashFlowAccount {

    /**
     * Расчётный счёт:
     *  - учёт полученных средств;
     *  - учёт вознаграждений.
     */
    settlement

}

enum SystemCashFlowAccount {

    /**
     * Расчётный счёт:
     *  - учёт полученных и возмещённых вознаграждений.
     */
    settlement

    /**
     * Расчётный счёт:
     * - проводки между внутренними участниками взаиморасчётов.
     */
    subagent

}

enum ExternalCashFlowAccount {

    /**
     * Счёт поступлений:
     *  - учёт любых поступлений в систему извне.
     */
    income

    /**
     * Счёт выводов:
     *  - учёт любых выводов из системы вовне.
     */
    outcome
}

enum WalletCashFlowAccount {
    sender_source
    sender_settlement
    receiver_settlement
    receiver_destination
}
