namespace java com.rbkmoney.payout.manager.base
namespace erlang payout_manager_base

/** Идентификатор */
typedef string ID

/** Идентификатор некоторого события в рамках одной машины */
typedef i32 SequenceID

/**
 * Отметка во времени согласно RFC 3339.
 *
 * Строка должна содержать дату и время в UTC в следующем формате:
 * `2016-03-22T06:12:27Z`.
 */
typedef string Timestamp

/**
 * Исключение, сигнализирующее о непригодных с точки зрения бизнес-логики входных данных
 */
exception InvalidRequest {
    /** Список пригодных для восприятия человеком ошибок во входных данных */
    1: required list<string> errors
}

