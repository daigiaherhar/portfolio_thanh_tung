import 'package:portfolio_thanh_tung/models/language_model.dart';

enum LanguageStatus { en, vi }

class LanguageState {
  final LanguageStatus status;

  LanguageState({this.status = LanguageStatus.en});

  LanguageState init() {
    return LanguageState(status: LanguageStatus.en);
  }

  LanguageState clone() {
    return LanguageState();
  }

  LanguageState copyWith({LanguageStatus? status}) {
    return LanguageState(status: status ?? this.status);
  }
}
