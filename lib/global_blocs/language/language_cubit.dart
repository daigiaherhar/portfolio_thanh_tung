import 'package:bloc/bloc.dart';

import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState().init()){
    _init();
  }
  _init() async {
   print("LanguageCubitLanguageCubit");
  }
  changeLanguage(LanguageStatus status){
    print("changeLanguage");
    emit(state.copyWith(status: status));
  }
   getStatus(){
    return state.status;
  }
}
