import 'package:flutter/material.dart';


enum NotifierState {busy, idle, error}

class BaseModel extends ChangeNotifier{
  NotifierState _state = NotifierState.idle;
  bool _mounted=true;

  BaseModel({NotifierState? state}){
    if(state!=null) _state = state;
  }

  NotifierState get state=> _state;
  bool get mounted => _mounted;
  bool get idle => _state == NotifierState.idle;
  bool get busy => _state == NotifierState.busy;
  bool get error=> _state == NotifierState.error;

  setBusy()=> setState(state: NotifierState.busy );
  setIdle()=> setState(state: NotifierState.idle );
  setError()=> setState(state: NotifierState.error );

  setState({NotifierState? state, bool notifierListener = true}){
    if(state != null)_state = state;
    if(mounted && notifierListener) notifyListeners();
  }
  
  @override
void dispose() {
    _mounted = false;
    super.dispose();
  }
}