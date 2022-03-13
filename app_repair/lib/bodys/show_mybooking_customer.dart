import 'dart:convert';

import 'package:app_repair/bodys/show_detail_service_customer.dart';
import 'package:app_repair/models/jobStatusModel.dart';
import 'package:app_repair/models/send_table_match_job.dart';

import 'package:app_repair/models/service_customer.dart';
import 'package:app_repair/models/table_find_repaierer_Model.dart';
import 'package:app_repair/models/user_model.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:app_repair/backend/backend.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:core';



class ShowBookingCustomer extends StatefulWidget {
  const ShowBookingCustomer({Key? key}) : super(key: key);

  @override
  _ShowBookingCustomerState createState() => _ShowBookingCustomerState();
}

class _ShowBookingCustomerState extends State<ShowBookingCustomer> {
  bool load = true;
  bool? haveData;
  List<ServiceCustomer> servicecustomerModels = [];
  List _items = [];
  String keyValueSend = "";
  List<String> keyText = [];
  List<jobStatusModel> jobStatusModelModels = [];
  List<tableMatchJob> tableMatchJobModels = [];
  List<UserModel> serivceRepaierModels = [];
  //List<jobStatusModel> jobStatusRepair
  List<tableFindRepaierer> tableFindRepaiererModels = [];




  /*StatusJsonShow(String idJob){
    writeJsonMyBook(idJob);
    //writeJsonMyBook("132022212054");
    readJsonPath();
    print("Key:: $keyValueSend");
    //if()
    writeJsonMyBookClear();
    return keyValueSend;
  }*/

  /*Future<void> readJsonPath() async {
    String text = "";
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonStatus.json');
    text = await file.readAsString();
    Map<String, dynamic> textKey = jsonDecode(text);    //print(text);
    print("===");
    print(textKey["valueStatus"]);
    setState(() {
      keyValueSend = textKey["valueStatus"];
    });
  }*/

  /*writeJsonMyBookClear(){
    writeJson("");
  }*/

  /*Future<void> writeJson(String textFile) async{
    print("textFile1:: $textFile");
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonStatus.json');
    await file.writeAsString(textFile);
    //final _myFile = File('assets/sample.json');
    //await _myFile.writeAsString(textFile);
  }*/
  /*writeJsonMyBook(String idJob) async{
    print("writeJson1");
    backend obj = new backend();
    String textKey = 'nonValue';
    String textValue = 'nonValue';
    //textValue = await obj.showIdJob(id);
    textKey = await obj.showStatus(idJob);
    String textForm = '{"valueStatus":"$textKey"}';
    writeJson(textForm);
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readMybooking();

    //writeJsonRun();

  }

  Future<Null>refreshPage()async{
    //readJsonStatusAll();
    readMybooking();
    setState(() {

    });
  }


  Future<Null> readMybooking() async {
    if (servicecustomerModels.length != 0) {
      servicecustomerModels.clear();
    } else {}

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');

    String showMyBooking =
        '${MyConstant.domain}/repairer_app/getServiceWhereUser.php?isAdd=true&id=$id';
    await Dio().get(showMyBooking).then((value) {
      //print('==>$value');

      if (value.toString() == 'null') {
        // No Data
        setState(() {
          load = false;
          haveData = false;
        });
      } else {
        // Have Data
        for (var item in json.decode(value.data)) {
          ServiceCustomer model = ServiceCustomer.fromMap(item);
          print('detail ==>> ${model.identifySymptoms}');

          setState(() {
            load = false;
            haveData = true;
            servicecustomerModels.add(model);
            readJobStatus(model.id_job);
            readTableMatch(model.id_job);
            readRepairer(id!);
          });
        }
      }
    });
  }

  readRepairer(String idRepairer) async {
      if (serivceRepaierModels.length != 0) {
        serivceRepaierModels.clear();
      } else {

      }

      String showUserCustomer = '${MyConstant
          .domain}/repairer_app/getUserWhereId.php?isAdd=true&id=$idRepairer';
      await Dio().get(showUserCustomer).then((value) {
        print('==>$value');
        if (value.toString() == 'null') {
          // No Data
          setState(() {
            //load = false;
            //haveData = false;
          });
        } else {
          // Have Data
          for (var item in json.decode(value.data)) {
            UserModel model = UserModel.fromMap(item);
            //print('detail ==>> ${model.identifySymptoms}');
            print('id2:: ${model.id}');
            print('firstname2:: ${model.firstname}');
            print('lastname2:: ${model.lastname}');
            print('type2:: ${model.type}');
            print('address2:: ${model.address}');
            print('phone2:: ${model.phone}');
            print('user2:: ${model.user}');
            print('password2:: ${model.password}');
            print('avatar2:: ${model.avatar}');
            print('lat2:: ${model.lat}');
            print('lng2:: ${model.lng}');
            print('type_technician2:: ${model.type_technician}');
            //readJobStatus(model.id_job);

            setState(() {
              //load = false;
              //haveData = true;
              serivceRepaierModels.add(model);
            });
          }
        }
      });

  }

  readJobStatus(String id_job) async{
    print("id_job_status :: $id_job");


    if (jobStatusModelModels.length != 0) {
      jobStatusModelModels.clear();
    } else {

    }


    String showJobStatus = '${MyConstant.domain}/repairer_app/getJobStatusWhereIdJob.php?isAdd=true&id_job=$id_job';
    await Dio().get(showJobStatus).then((value) {
      print('==>$value');


      if (value.toString() == 'null') {
        print("id_job_status null ");
        // No Data
        setState(() {
          //load = false;
          //haveData = false;
        });
      } else {
        // Have Data
        for (var item in json.decode(value.data)) {
          jobStatusModel model = jobStatusModel.fromMap(item);
          //print('detail ==>> ${model.identifySymptoms}');
          print('id_job1:: ${model.id_job}');
          print('date_start1:: ${model.date_start}');
          print('date_end1:: ${model.date_end}');
          print('status_work1:: ${model.status_work}');
          print('orderStart_date1:: ${model.orderStart_date}');
          print('orderEnd_date1:: ${model.orderEnd_date}');
          print('order_job1:: ${model.order_job}');



          setState(() {
            //load = false;
            //haveData = true;
            //tableMatchJobModels.add(model);
            jobStatusModelModels.add(model);
          });
        }

      }
    });
  }

   readTableMatch(String id_job) async {
    print("readTableMatch101");
    if (tableMatchJobModels.length != 0) {
      tableMatchJobModels.clear();
    } else {

    }
    //deleteNumberMatch();



    String showNewJob = '${MyConstant.domain}/repairer_app/getTableMatchJobWhereIdJob.php?isAdd=true&id_job=$id_job';
    await Dio().get(showNewJob).then((value) {
      print('==>$value');
      if (value.toString() == 'null') {
        print("readTableMatchNULL");
        setState(() {
          //load = false;
          //haveData = false;
        });
      } else {
        // Have Data
        for (var item in json.decode(value.data)) {
          int count = 0;
          tableMatchJob model = tableMatchJob.fromMap(item);
          //print('detail ==>> ${model.identifySymptoms}');
          print('id_customer101:: ${model.id_customer}');
          print('id_repairer101:: ${model.id_repairer}');
          print('id_job101:: ${model.id_job}');
          print('orderMatch101:: ${model.orderMatch}');



          setState(() {
          //  load = false;
          //  haveData = true;
            readRepairer(model.id_repairer);
            readStatusTableFindRepaierer(model.id_repairer);
            tableMatchJobModels.add(model);
          });
         // count++;
        }

      }
    });

  }

  readStatusTableFindRepaierer(idRepairer) async {
    print("readTableMatch101");
    if (tableFindRepaiererModels.length != 0) {
      tableFindRepaiererModels.clear();
    } else {

    }
    //deleteNumberMatch();



    String showNewJob = '${MyConstant.domain}/repairer_app/getTableFindRepaiererWhereIdRepairer.php?isAdd=true&id=$idRepairer';
    await Dio().get(showNewJob).then((value) {
      print('==>$value');
      if (value.toString() == 'null') {
        print("readTableMatchNULL");
        setState(() {
          //load = false;
          //haveData = false;
        });
      } else {
        // Have Data
        for (var item in json.decode(value.data)) {
          //int count = 0;
          tableFindRepaierer model = tableFindRepaierer.fromMap(item);
          //print('detail ==>> ${model.identifySymptoms}');
          print('type_repairer50:: ${model.type_repairer}');
          print('lat50:: ${model.lat}');
          print('lng50:: ${model.lng}');
          print('status_repairer50:: ${model.status_repairer}');
          print('price50:: ${model.price}');
          print('id_repairer50:: ${model.id_repairer}');




          setState(() {
            //  load = false;
            //  haveData = true;
            //readRepairer(model.id_repairer);
            tableFindRepaiererModels.add(model);
          });
          // count++;
        }

      }
    });
  }


  statusWithIdJob(String id_job){
    String status = "nonIdentifySymptoms";
    for(int i = 0;i<jobStatusModelModels.length;i++){
      if(jobStatusModelModels[i].id_job == id_job){
        status = jobStatusModelModels[i].status_work;
        break;
      }
    }
    return status;
  }


    @override
  Widget build(BuildContext context) {
    //writeJsonRun();
    //readJsonStatusAll();
    if(_items.isEmpty) {

    }else{
      print("++1+");
      print(_items[0]);
    }
    //writeJsonMyBook("131999513800");
    //readJsonPath();
    //print("Key:: $keyValueSend");
    return Scaffold(
    /*  backgroundColor: Colors.orange.shade100,
        body: Padding(
            padding: const EdgeInsets.all(25),
        child: Column(
                children: [


        // Display the data loaded from sample.json

                      Expanded(
                          child: ListView.builder(
                            itemCount: 1,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: const EdgeInsets.all(10),
                                  child: ListTile(
                                      leading: Text(keyValueSend),
                                      title: Text(""),
                                      subtitle: Text(""),
                                  ),
                                );
                              },
                          ),
                      )

                  ],
                ),
        )
        ,
     */

      body: load
          ? ShowProgress()
          : haveData! //&& keyText.isNotEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) => buildListView(constraints))
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShowTitle(
                        title: 'ยังไม่มีรายการซ่อม',
                        textStyle: MyConstant().h1BlackStyle()),
                    ShowTitle(
                        title: 'เมื่อทำการแจ้งซ่อม รายการแจ้งซ่อมจะขึ้นที่นี่',
                        textStyle: MyConstant().h2BlackStyle()),
                  ],
                  )
              )

    );
  }

  /*
  Future<String> StringToJsonFormat( List<String>  text,int sizeArr) async {
    backend obj = new backend();
    String ans = "{";
    for(int i = 0;i < sizeArr;i++){
      String textStatus = await obj.showStatus(text[i]);
      if(i < sizeArr - 1) {
        //String key = text[i];
        ans += '"$i":"$textStatus",';
      }else{
        //String key = text[i];
        ans += '"$i":"$textStatus"';
      }
    }
    ans += "}";
    print(ans);
    return ans;
  }
  */


  /*readJsonStatusAll() async {
    String text = "";
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonStatus.json');
    text = await file.readAsString();
    Map<String, dynamic> textKey = jsonDecode(text);    //print(text);
    print("===");
    print(textKey["0"]);
    setState(() {
      for(int i = 0;i< textKey.length;i++){
        keyText.add(textKey["$i"]);
      }
    });
    print(keyText);
  }*/
  /*
  writeJsonStatusAll(List<String> text,int sizeArr) async {
    String value = await  StringToJsonFormat(text, sizeArr);
    writeJson(value);
  }*/

  /*
  writeJsonRun(){
    List<String> stringArr = [];
    for(int i = 0;i < servicecustomerModels.length;i++) {
      print(i);
      stringArr.add(servicecustomerModels[i].id_job);
      print(stringArr);

    }
    writeJsonStatusAll(stringArr,servicecustomerModels.length);
  }*/


  RefreshIndicator buildListView(BoxConstraints constraints) {




    //StringToJsonFormat(stringArr,servicecustomerModels.length);

    /*
    if(keyText.isEmpty) {
      print("keyText isEmpty");
    }else{
      print("+101++");
      //print(_items[0]);
    }
    */

    //writeJsonMyBook("131999513800");
    //readJsonPath();
    //print("Key:: $keyValueSend");
    //writeJsonMyBookClear();
    //StatusJsonShow("132022212054");

    return RefreshIndicator(
      onRefresh:readMybooking,
      child: ListView.builder(
        itemCount: servicecustomerModels.length,
        itemBuilder: (context, index) => Card(
          child: Row(

            children: [

              Container(
                padding: EdgeInsets.only(top: 10, left: 10),
                width: 50,
                height: 50,
                child: Icon(Icons.handyman_rounded),

              ),
              Expanded(

                child: Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              servicecustomerModels[index].typeRepairer,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              print('## click Detail');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ShowDetailServiceCustomer(
                                          servicecustomerModels[index],
                                            jobStatusModelModels[index],
                                            tableMatchJobModels[index],
                                            serivceRepaierModels[index],
                                            tableFindRepaiererModels[index],
                                    ),
                                  ));
                            },
                            icon:
                                Icon(Icons.arrow_forward_ios_outlined, size: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        servicecustomerModels[index].date1 +
                            ',' +
                            servicecustomerModels[index].identifySymptoms,
                        style: MyConstant().h4Style(),
                      ),
                      Text(
                        'สถานะ '+
                            // add boom
                            //keyValueSend,
                            //StatusJsonShow(servicecustomerModels[index].id_job),
                        //servicecustomerModels[index].id_job,
                            //keyText[index],
                            statusWithIdJob(servicecustomerModels[index].id_job),
                        style: MyConstant().h3BlackStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
