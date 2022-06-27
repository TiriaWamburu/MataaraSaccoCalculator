import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:telephony/telephony.dart';

part 'sms_event.dart';
part 'sms_repository.dart';
part 'sms_state.dart';
part 'sms_bloc.freezed.dart';

class SmsBloc extends Bloc<SmsEvent, SmsState> {
  SmsBloc({
    required this.smsRepository,
  }) : super(_Initial()) {
    on<SmsEvent>((event, emit) async {
      await event.when(
        started: () async {
          try {
            emit(SmsState.loading());
            final transactions = await smsRepository.getTransactions();
            emit(SmsState.loaded(transactions));
          } catch (e) {
            emit(SmsState.error(e.toString()));
          }
        },
      );
    });
  }

  final SmsRepository smsRepository;
}
