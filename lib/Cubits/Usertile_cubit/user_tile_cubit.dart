import 'package:bloc/bloc.dart';
import 'package:chat/Cubits/chat_cubit/chat_cubit.dart';
import 'package:chat/models/User_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_tile_state.dart';

class UserTileCubit extends Cubit<UserTileState> {
  UserTileCubit() : super(UserTileInitial());

  Future<void> moveToChat({
    required BuildContext context,
    required Usermodel usermodel,
    required CollectionReference collectionReference,
  }) async {
    emit(UserTileLoading());
    await BlocProvider.of<ChatCubit>(context).getMessages(
        collectionReference: collectionReference, usermodel: usermodel);
    emit(UserTileSuccess());
  }
}
