import 'package:flutter_test/flutter_test.dart';
import 'package:maataara_sacco_calculator/sms/bloc/sms_bloc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SmsRepository smsRepository;
  const sms = '''
TYRE ACCOUNT

KES 200.00 Received at RUIRU TOWN on Jun 22 2022 12:06PM. Payment Reference : KBX225V. Receipt No.: 233008
''';

  setUp(() {
    smsRepository = SmsRepository();
  });

  test('Can extract account', () {
    final ref = smsRepository.parseSms(sms);
    expect(ref.account, 'TYRE ACCOUNT');
  });
  test('Can extract amount', () {
    final ref = smsRepository.parseSms(sms);
    expect(ref.amount, 200);
  });
  test('Can extract ReceivedAt', () {
    final ref = smsRepository.parseSms(sms);
    expect(ref.receivedAt, 'RUIRU TOWN');
  });
  test('Can extract date', () {
    final ref = smsRepository.parseSms(sms);
    expect(ref.date, 'Jun 22 2022 12:06PM');
  });

  test('Can extract number plate', () {
    final ref = smsRepository.parseSms(sms);
    expect(ref.numberPlate, 'KBX225V');
  });

  test('Can extract receipt number', () {
    final ref = smsRepository.parseSms(sms);
    expect(ref.receiptNo, '233008');
  });
}
