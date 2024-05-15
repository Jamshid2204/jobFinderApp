import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobfinderapp/constants/app_constants.dart';

class FirebaseServices {
  CollectionReference typing = FirebaseFirestore.instance.collection('typing');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  CollectionReference status = FirebaseFirestore.instance.collection('status');
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  createChatRoom({chatData}) {
    chats.doc(chatData['chatRoomId']).set(chatData).catchError((e) {
      debugPrint(e.toString());
    });
  }

  void addTypingStatus(String chatRoomId) {
    typing.doc(chatRoomId).collection('typing').doc(userUid).set({});
  }

  void removeTypingStatus(String chatRoomId) {
    typing.doc(chatRoomId).collection('typing').doc(userUid).set({});
  }

  createChat(String chatRoomId, message) {
    typing.doc(chatRoomId).collection('message').add(message).catchError((e) {
      debugPrint(e.toString());
    });
    removeTypingStatus(chatRoomId);
    chats.doc(chatRoomId).update({
      'messageType': message['messageType'],
      'sender': message['sender'],
      'profile': message['profile'],
      'id': message['id'],
      'timestamp': Timestamp.now(),
      'lastChat': message['message'],
      'lastChatTime': message['time'],
      'read': false,
    });
  }

  updateCount(String chatRoomId) {
    chats.doc(chatRoomId).update({'read': true});
  }

  // Future<bool> chatRoomExists(chatRoomId) async{
  //   DocumentReference chatRoomRef = chats.doc(chatRoomId);
  //   DocumentReference chatRoomSnapshot = await chatRoomRef.get();

  //   return chatRoomSnapshot.exists;
  // }

  Future<bool> chatRoomExists(String chatRoomId) async {
    try {
      DocumentSnapshot chatRoomSnapshot = await chats.doc(chatRoomId).get();
      return chatRoomSnapshot.exists;
    } catch (e) {
      debugPrint("Error checking chat room existence: $e");
      return false;
    }
  }
}
