
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dialogos{
   
  static showAlertDialog(BuildContext context, String mensagem){
     // definir um botão para ok
     Widget okButton = FlatButton(
       child: Text('Ok'),
       onPressed: () { 
         Navigator.of(context).pop(); 
       } 
     );
     // definir Alert Dialog
     AlertDialog alerta = AlertDialog(
       title: Text('Alerta'),
       content: Text(mensagem),
       actions: [
         okButton
       ],
     );
     // exibir
     showDialog(context: context,
        builder: (BuildContext context){
          return alerta;
        }
     );

  } 
  
  static showConfirmDialog(BuildContext context, String mensagem,
     Function simFunction){
     // definir um botão para sim
     Widget simButton = FlatButton(
       child: Text('Sim'),
       onPressed: () { 
         simFunction();
         Navigator.of(context).pop(); 
       } 
     );
     // definir um botão para não
     Widget naoButton = FlatButton(
       child: Text('Não'),
       onPressed: () { 
         Navigator.of(context).pop(); 
       } 
     );
     // definir Alert Dialog
     AlertDialog alerta = AlertDialog(
       title: Text('Confirmação'),
       content: Text(mensagem),
       actions: [
         simButton, naoButton
       ]
     );
     // exibir
     showDialog(context: context,
        builder: (BuildContext context){
          return alerta;
        }
     );
     
  } 

 static void showToastError(String mensagem){
   Fluttertoast.showToast(
        msg: mensagem,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
 }

 static void showToastSuccess(String mensagem){
   Fluttertoast.showToast(
        msg: mensagem,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
 }





}