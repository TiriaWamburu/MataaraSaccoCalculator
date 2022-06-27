part of 'sms_bloc.dart';

class SmsRepository {
  final Telephony telephony = Telephony.instance;

  Future<List<Transaction>> getTransactions() async {
    final messages = await telephony.getInboxSms(
      filter: SmsFilter.where(SmsColumn.ADDRESS).equals('MATAARATSCO'),
    );
    return messages.map(_convertMessageToTransaction).toList();
  }

  Transaction _convertMessageToTransaction(SmsMessage message) {
    return Transaction(
      date: 'date',
      sms: message.body!,
      receiptNo: 'receiptNo',
      name: 'name',
      amount: 1000,
      receivedAt: 'receivedAt',
      numberPlate: 'numberPlate',
    );
  }
}
