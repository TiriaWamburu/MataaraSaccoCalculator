import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maataara_sacco_calculator/sms/bloc/sms_bloc.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmsBloc, SmsState>(
      builder: (context, state) {
        return Scaffold(
          body: state.when(
            initial: () => const Center(child: Text('Welcome')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (sms) {
              if (sms.isEmpty) {
                return const Center(child: Text('No Transactions Found'));
              } else {
                return ListView.builder(
                  itemBuilder: (context, idx) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent),
                    ),
                    child: ListTile(
                      title: Text(sms[idx].sms),
                    ),
                  ),
                  itemCount: sms.length,
                );
              }
            },
            error: (error) => Center(
              child: Text(error),
            ),
          ),
          appBar: AppBar(
            title: const Text('Transactions'),
          ),
        );
      },
    );
  }
}
