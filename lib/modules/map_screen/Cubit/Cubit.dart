import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riderapp/models/AddressModel.dart';
import 'States.dart';

class MapScreenCubit extends Cubit<MapScreenState>{
  MapScreenCubit() : super(MapScreenInitialState());
  static MapScreenCubit get(context)=>BlocProvider.of(context);

  AddressModel AdressModelCubit = AddressModel();

  UpdatePickUpLocation (AddressModel AdressPickUp){
    AdressModelCubit = AdressPickUp;
    emit(MapScreenUpdateState());
  }

}