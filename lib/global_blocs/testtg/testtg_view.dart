import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'testtg_bloc.dart';
import 'testtg_event.dart';
import 'testtg_state.dart';

class TesttgPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TesttgBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<TesttgBloc>(context);
    return Container();
  }
}

