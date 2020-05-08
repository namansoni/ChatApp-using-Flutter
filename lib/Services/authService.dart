import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class authService with ChangeNotifier{
    String token;
    DateTime expiryDate;
    String userId; 
    String email1;
    Future<void> signUp(String email,String password) async{
      print(email);
      print(password);
      
      try{
          var url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[YOUR API KEY]';
          final signUpResponse=await http.post(url,body: json.encode({
          'email':email,
          'password':password,
          'returnSecureToken':true,
        }));
      final signUpResponseData=json.decode(signUpResponse.body);
      userId=signUpResponseData['localId'];
      email1=signUpResponseData['email'];
     await Firestore.instance.collection('books').add({
       'title':'title',
       'author':'author'
     });
      if(signUpResponseData['error'] !=null){
        throw signUpResponseData['error']['message'];
      }
      }catch(error){
            throw error.toString();
      }
    }

    Future<void> signIn(String email,String password) async{
      var url="https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[YOUR API KEY]";
      try{
          final signInResponse=await http.post(url,body:json.encode({
          'email': email,
          'password':password,
          'returnSecureToken':true,
        }));
        final signInResponseData=json.decode(signInResponse.body);
        
        userId=signInResponseData['localId'];
        email1=signInResponseData['email'];
        print(userId);
        print(email);
        if(signInResponseData['error']!=null){
          throw signInResponseData['error']['message'];
        }
      }catch(error){
        throw error.toString();
      }
    }
    
    String get UserId=>userId;
    String get UserMail=>email1;

}
