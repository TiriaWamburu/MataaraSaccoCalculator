part of 'sms_bloc.dart';

@freezed
class SmsEvent with _$SmsEvent {
  const factory SmsEvent.started() = _Started;
}
