part of 'sms_bloc.dart';

class SmsRepository {
  final Telephony telephony = Telephony.instance;

  Future<List<Transaction>> getTransactions() async {
    final messages = await telephony.getInboxSms(
      filter: SmsFilter.where(SmsColumn.ADDRESS).equals('MATAARATSCO'),
    );
    return messages.map((e) => e.body!).map(parseSms).toList();
  }

  Transaction parseSms(String sms) {
    final accountRegex = RegExp(r'^\w{0,} ACCOUNT');
    if (!accountRegex.hasMatch(sms)) {
      throw Exception('Account not found when parsing sms');
    }
    final account = accountRegex.stringMatch(sms)!;

    final amountRegex = RegExp(
      r'KES \d{0,}.00 ',
      dotAll: true,
      multiLine: true,
    );
    if (!amountRegex.hasMatch(sms)) {
      throw Exception('Amount not found when parsing sms');
    }
    final amount = amountRegex.stringMatch(sms)!.replaceAll('KES ', '');

    final receivedAtRegex = RegExp(r'Received at \w{0,} \w{0,}');
    if (!receivedAtRegex.hasMatch(sms)) {
      throw Exception('ReceivedAt not found when parsing sms');
    }
    final receivedAt = receivedAtRegex.stringMatch(sms)!;

    final dateRegex = RegExp(r'on \w{0,} \w{0,} \w{0,} \w{0,}:\w{0,}');
    if (!dateRegex.hasMatch(sms)) {
      throw Exception('Date not found when parsing sms');
    }
    final date = dateRegex.stringMatch(sms)!;

    final numberPlateRegex = RegExp(r'Payment Reference : \w{0,}');
    if (!numberPlateRegex.hasMatch(sms)) {
      throw Exception('Number Plate not found when parsing sms');
    }
    final numberPlate = numberPlateRegex.stringMatch(sms)!;

    final receiptNoRegex = RegExp(r'Receipt No.: \w{0,}');
    if (!receiptNoRegex.hasMatch(sms)) {
      throw Exception('Number Plate not found when parsing sms');
    }
    final receiptNo = receiptNoRegex.stringMatch(sms)!;

    return Transaction(
      account: account,
      date: date.replaceAll('on ', ''),
      sms: sms,
      receiptNo: receiptNo.replaceAll('Receipt No.: ', ''),
      amount: double.parse(amount),
      receivedAt: receivedAt.replaceAll('Received at ', ''),
      numberPlate: numberPlate.replaceAll('Payment Reference : ', ''),
    );
  }
}
