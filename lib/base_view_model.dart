
import 'package:flutter/material.dart';
import 'package:tutor_finder/enums/view_state.dart';

class BaseViewModel extends ChangeNotifier{

  ViewState? _viewState =ViewState.idle;

  ViewState? get viewState => _viewState;

  setstate (ViewState state){
    _viewState = state;
    notifyListeners();
  }
}