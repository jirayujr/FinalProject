import 'dart:convert';
import 'package:app_repair/backend/backend.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:app_repair/models/chat_table_Model.dart';
import 'package:app_repair/resolve/style.dart';
import 'package:app_repair/backend/chatBackend.dart';
import 'package:app_repair/models/send_table_match_job.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ShowDetailMessage extends StatefulWidget {
 // const ShowDetailMessage({ Key? key }) : super(key: key);
  String idCustomerShowDetailMessage = "";
  String typeUserShowDetailMessage = "";
  String idRepairerShowDetailMessage = "";

  ShowDetailMessage(String idUser,String typeUser,String idRepairer){
    print("idUser:: $idUser");
    print("typeUser:: $typeUser");
    this.idCustomerShowDetailMessage = idUser;
    this.typeUserShowDetailMessage = typeUser;
    this.idRepairerShowDetailMessage = idRepairer;
  }

  @override
  _ShowMessageDetailState createState() => _ShowMessageDetailState(idCustomerShowDetailMessage,typeUserShowDetailMessage,idRepairerShowDetailMessage);
}

class _ShowMessageDetailState extends State<ShowDetailMessage> {

  //defintion value
  final List<Map<String, String>> _chatMessages = [];
  final massageClear = TextEditingController();
  String? massageText;
  List<tableMatchJob> tableMatchJobModels = [];
  List<chat_table_Model> chatTableModel = [];

  bool useValue = true;

  int court = 0;
  int lastRecond = 0;
  int amount = 0;
  int numLast = 0;
  int lastOrder = 0;
  int lastOrderNew = 0;
  bool keyValue = true;
  String? idValue = "";

  String idCustomerShowMessageDetailState = "";
  String typeUserShowMessageDetailState = "";
  String idRepairerShowMessageDetailState = "";

  DateTime _dateTime = new DateTime.now();
  TimeOfDay _timeOfDay = new TimeOfDay.now();


  _ShowMessageDetailState(String idCustomer,String typeUser,String idRepairer){
    this.idCustomerShowMessageDetailState = idCustomer;
    this.typeUserShowMessageDetailState = typeUser;
    this.idRepairerShowMessageDetailState = idRepairer;
    print("idUserShowMessageDetailState:: $idCustomerShowMessageDetailState");
    print("typeUserShowMessageDetailState:: $typeUserShowMessageDetailState");
    print("idRepairerShowMessageDetailState:: $idRepairerShowMessageDetailState");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setIdValue();
  }

  setIdValue() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.idValue = preferences.getString('id');
  }


  Future<Null> readMybooking() async {
    String? id_customer = "";
    String? id_repairer = "";
    if (chatTableModel.length != 0) {
      chatTableModel.clear();
    } else {

    }

    if(typeUserShowMessageDetailState == "user") {
      print("typeUserShowMessageDetailState == user");
      //String? id = "1";
      //id = idUserShowMessageDetailState;
      //String showNewJob = 'http://10.0.2.2/repairer_app/getChatTableWhereIdCustomer.php?isAdd=true&id=$id';

      id_customer = idCustomerShowMessageDetailState;
      id_repairer = idRepairerShowMessageDetailState;
      String showNewJob = 'http://10.0.2.2/repairer_app/getChatTableWhereIdCustomerIdRepairer.php?isAdd=true&id_customer=$id_customer&id_repairer=$id_repairer';


      await Dio().get(showNewJob).then((value) {
        print('==>$value');
        if (value.toString() == 'null') {
          // No Data
          setState(() {

          });
        } else {
          // Have Data
          for (var item in json.decode(value.data)) {
            int count = 0;
            chat_table_Model model = chat_table_Model.fromMap(item);
            //print('detail ==>> ${model.identifySymptoms}');
            print('id_customer:: ${model.id_customer}');
            print('id_repairer:: ${model.id_repairer}');
            print('firstname_customer:: ${model.firstname_customer}');
            print('firstname_repairer:: ${model.firstname_repairer}');
            print('time:: ${model.time}');
            print('date:: ${model.date}');
            print('text_detail:: ${model.text_detail}');
            print('orderChat:: ${model.orderChat}');
            print('whoSend:: ${model.whoSend}');


            setState(() {
              chatTableModel.add(model);
            });
            count++;
          }
        }
      });
    }else if(typeUserShowMessageDetailState == "technician"){


      print("typeUserShowMessageDetailState == technician");

      id_customer = idCustomerShowMessageDetailState;
      id_repairer = idRepairerShowMessageDetailState;

      print("id_customer101:: $id_customer");
      print("id_repairer101:: $id_repairer");


      id_customer = idCustomerShowMessageDetailState;
      id_repairer = idRepairerShowMessageDetailState;
      String showNewJob = 'http://10.0.2.2/repairer_app/getChatTableWhereIdCustomerIdRepairer.php?isAdd=true&id_customer=$id_customer&id_repairer=$id_repairer';


      await Dio().get(showNewJob).then((value) {
        print('==>$value');
        if (value.toString() == 'null') {
          // No Data
          setState(() {

          });
        } else {
          // Have Data
          for (var item in json.decode(value.data)) {
            int count = 0;
            chat_table_Model model = chat_table_Model.fromMap(item);
            //print('detail ==>> ${model.identifySymptoms}');
            print('id_customer:: ${model.id_customer}');
            print('id_repairer:: ${model.id_repairer}');
            print('firstname_customer:: ${model.firstname_customer}');
            print('firstname_repairer:: ${model.firstname_repairer}');
            print('time:: ${model.time}');
            print('date:: ${model.date}');
            print('text_detail:: ${model.text_detail}');
            print('orderChat:: ${model.orderChat}');
            print('whoSend:: ${model.whoSend}');


            setState(() {
              chatTableModel.add(model);
            });
            count++;
          }
        }

      });


    }
  }

  // More messages added to the _chatMessages over time
  Stream<List<Map<String, String>>> _chat() async* {


    while(true){

      print("while");

      chatBackend obj = new chatBackend();

      lastOrderNew = await obj.GetLastRecordBackend();
      //keyValue = await obj.CheckIdCustomerWithlastIdBool("1");

      keyValue = await obj.CheckIdCustomerWithlastIdBool(idCustomerShowMessageDetailState);


      print("keyValue :: $keyValue");

      if(court == 0){
        print("court == 0");
        readMybooking();
        lastOrder = lastOrderNew;
        court = court + 1;

      }else if(lastOrder < lastOrderNew && keyValue == true){
        print("lastorder +> $lastOrder");
        print("lastOrderNew +> $lastOrderNew");
        String detail = await obj.showdetailWithlastId();
        String whoSend = await obj.showWhoSendWithlastId();
        _chatMessages.add({"user_name": "$whoSend", "message": "$detail"});
        yield _chatMessages;
        lastOrder = lastOrderNew;
      }


      await Future<void>.delayed(const Duration(seconds: 0));

      if(amount < chatTableModel.length && useValue == true) {
        for (int i = 0; i < chatTableModel.length; i++) {
          print("for");
          String firstname = chatTableModel[i].whoSend;
          String textDetail = chatTableModel[i].text_detail;
          _chatMessages.add({"user_name": "$firstname", "message": "$textDetail"});
          yield _chatMessages;
        }
        amount = chatTableModel.length;
        useValue = false;
      }

      keyValue = false;

    }
  }

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body:  Text('Show message'),

    );
  }
*/

  @override
  Widget build(BuildContext context) {
    print("show12");
    print("id:: $idValue");
    return Scaffold(

      appBar: AppBar(
        title: Text('chat'),
        actions: [],
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow.shade900, Colors.yellowAccent.shade700],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),


      /*
      appBar: AppBar(
        title: const Text('pattadon nutes'),
      ),
      */

      backgroundColor: Colors.orange.shade100,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: StreamBuilder(
          stream: _chat(),
          builder:
              (context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final chatItem = snapshot.data![index];
                  return ListTile(
                    leading: Text(
                      chatItem["user_name"] ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    title: Text(
                      chatItem["message"] ?? '',
                      style: TextStyle(
                          fontSize: 20,
                          color: chatItem['user_name'] == 'Trump'
                              ? Colors.pink
                              : Colors.blue),
                    ),
                  );
                },
              );
            }else{
              print("no");
            }
            return const LinearProgressIndicator();
          },
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        //hasNotch: true,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextField(

                controller: massageClear,
                onChanged: (value) {
                  massageText = value;
                },
                decoration: kMessageTextFieldDecoration,
              ),

            ),
            TextButton(
              onPressed: () async {
                print("hello send");
                print(massageText);
                massageClear.clear();
                chatBackend obj = new chatBackend();
                backend objBackEnd = new backend();
                String dateText = DateFormat.yMd().format(DateTime.now());
                String timeText = DateFormat.Hm().format(DateTime.now());
                String dateMeetText = DateFormat.yMd().format(_dateTime);
                String timeMeetText = "";
                String hourText = "";
                String minText = "";




                if(_timeOfDay.hour > 9){
                  hourText = _timeOfDay.hour.toString();
                }else{
                  hourText = "0"+_timeOfDay.hour.toString();
                }

                if(_timeOfDay.minute > 9){
                  minText = _timeOfDay.minute.toString();
                }else{
                  minText = "0"+_timeOfDay.minute.toString();
                }

                timeMeetText = hourText+":"+minText;

                obj.insertChatSQL(idCustomerShowMessageDetailState, idRepairerShowMessageDetailState,await objBackEnd.showFirstName(idCustomerShowMessageDetailState), await objBackEnd.showFirstName(idRepairerShowMessageDetailState), timeText, dateText, massageText,await obj.addGetLastRecord(),typeUserShowMessageDetailState);
                // await Future<void>.delayed(const Duration(seconds: 1));
                //String ans = await obj.showdetailWithlastId();
                //_chatMessages.add({"user_name": "Trump", "message": "$ans"});
                //_chat();
                /*
                massageClear.clear();
                _firestore.collection('massages').add({
                  'txet': massageText,
                  'sender': loggedInUser.email,
                  'time': FieldValue.serverTimestamp(),
                });
                */
              },
              child: const Text(
                'Send',
                style: kSendButtonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}