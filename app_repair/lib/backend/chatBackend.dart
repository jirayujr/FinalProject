


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class chatBackend extends State{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  /*
  insertChat(){

  }
  */


  Future<Null> insertChatSQL(
      String? id_customer,
        String? id_repairer,
        String? firstname_customer,
        String? firstname_repairer,
        String? time,
        String? date,
        String? text_detail,
        String? orderChat,String? whoSend) async {
    String apiInsertUser =
        'http://10.0.2.2/repairer_app/insertChat.php?isAdd=true&id_customer=$id_customer&id_repairer=$id_repairer&firstname_customer=$firstname_customer&firstname_repairer=$firstname_repairer&time=$time&date=$date&text_detail=$text_detail&orderChat=$orderChat&whoSend=$whoSend';
    await Dio().get(apiInsertUser).then((value) {
      if (value.toString() == 'true') {
        print("ok");
        //Navigator.pop(context);
      } else {
        print("error again");
        /*
        MyDialog()
            .normalDialog(context, 'Create New User Fail', 'Please Try Again');

         */
      }
    });
  }



  Future<String> getLastRecordBackend(
      String tableName, String getLastRecond) async {
    print("=getLastRecord=");
    var url = 'http://10.0.2.2/repairer_app/getLastRecond.php';
    //print(await http.read(Uri.parse(url)));
    //data send to php
    var data = {'table_name': tableName, 'get_recond': getLastRecond};

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    print(await http.read(Uri.parse(url)));

    // check value
    var textMessage = response.body;
    String text = textMessage; // set string text
    print("getLastRecord:: $text");
    return text;
  }

  GetLastRecordBackend() async {
    String num = await getLastRecordBackend("chat_table", "orderChat");
    print("numberLastRecord:: $num");
    var lastNum = int.parse(num);
    return lastNum;
  }

  addGetLastRecord() async {
    String text = await getLastRecordBackend("chat_table", "orderChat");
    print("addGetLastRecond:: $text");
    //var num = 4;
    var num = int.parse(text);
    num = num +1;
    print(num);
    return num.toString();
  }

  GetLastRecordBackendString() async{
    String num = await getLastRecordBackend("chat_table", "orderChat");
    return num;
  }

  Future<String> selectRecondBackend(String tableName, String selectName,
      String typeCondition, String valueCondition) async {
    String ans = "";
    print("=selectBackend=");
    var url = 'http://10.0.2.2/repairer_app/selectDataMySql.php';
    var data = {
      'table': tableName,
      'selectName': selectName,
      'conditionName': typeCondition,
      'valueConditionName': valueCondition
    };
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    var textMessage = response.body;
    ans = textMessage;
    //print(ans);
    return ans;
  }

  Future<String> showdetailWithlastId() async {
    String key = await getLastRecordBackend("chat_table", "orderChat");
    String text = await selectRecondBackend("chat_table", "text_detail", "orderChat", key);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showWhoSendWithlastId() async {
    String key = await getLastRecordBackend("chat_table", "orderChat");
    String text = await selectRecondBackend("chat_table", "whoSend", "orderChat", key);
    print("=================");
    print(text);
    return text;
  }

  Future<String> CheckIdCustomerWithlastId() async {
    String key = await getLastRecordBackend("chat_table", "orderChat");
    String text = await selectRecondBackend("chat_table", "id_customer", "orderChat", key);
    print("=================");
    print(text);
    return text;
  }

  CheckIdCustomerWithlastIdBool(String idCustomer) async {
    String ans = await CheckIdCustomerWithlastId();
    if(idCustomer == ans){
      return true;
    }else{
      return false;
    }
  }

}