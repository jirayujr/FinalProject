import 'dart:convert';

import 'package:app_repair/bodys/show_detail_myjob.dart';
import 'package:app_repair/bodys/show_detail_service_technician.dart';
import 'package:app_repair/bodys/show_detail_service_customer.dart';
import 'package:app_repair/models/give_fix2_Model.dart';
import 'package:app_repair/models/send_table_match_job.dart';
import 'package:app_repair/models/service_customer.dart';
import 'package:app_repair/models/user_model.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:app_repair/backend/backend.dart';
import 'package:app_repair/models/jobStatusModel.dart';



class ShowCurrentJob extends StatefulWidget {
  const ShowCurrentJob({ Key? key }) : super(key: key);

  @override
  _ShowCurrentJobState createState() => _ShowCurrentJobState();
}

class _ShowCurrentJobState extends State<ShowCurrentJob> {
  bool load = true;
  bool? haveData;
   List<ServiceCustomer> servicecustomerModels = [];

  List<tableMatchJob> tableMatchJobModels = [];
  List<jobStatusModel> jobStatusModelModels = [];
  List<give_fix2_Model> GiveFix2Models = [];
  List<UserModel> UserModel_Models = [];

  List<int> NumberMatchStatus = [];

  List<String>firstNameText = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readMybooking();
  }
/*
  SetMatchJobStatus(){
    print("setMatchJobStatus");
    if(NumberMatchStatus.length != 0){
      NumberMatchStatus.clear();
    }else{

    }
    for(int i = 0;i < jobStatusModelModels.length;i++){
      if(jobStatusModelModels[i].status_work == "match"){
        NumberMatchStatus.add(i);
      }
    }
    print(NumberMatchStatus);
  }*/

  Future<Null>refreshPage()async{
    readMybooking();

  }

  //add 9/2/2565
  Future<Null> readMybooking() async {
    if (tableMatchJobModels.length != 0) {
      tableMatchJobModels.clear();
    } else {

    }
    //deleteNumberMatch();


    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');

    String showNewJob = '${MyConstant.domain}/repairer_app/getTableMatchJobWhereUser.php?isAdd=true&id=$id';
    await Dio().get(showNewJob).then((value) {
      print('==>$value');
      if (value.toString() == 'null') {
        // No Data
        setState(() {
          load = false;
          haveData = false;
        });
      } else {
        // Have Data
        for (var item in json.decode(value.data)) {
          int count = 0;
          tableMatchJob model = tableMatchJob.fromMap(item);
          //print('detail ==>> ${model.identifySymptoms}');
          print('id_customer:: ${model.id_customer}');
          print('id_repairer:: ${model.id_repairer}');
          print('id_job:: ${model.id_job}');
          print('orderMatch:: ${model.orderMatch}');

          readJobStatus(model.id_job);
          readUserModel(model.id_customer);
          readGiveFix2(model.id_job);

          setState(() {
            load = false;
            haveData = true;
            tableMatchJobModels.add(model);
          });
          count++;
        }

      }
    });

      print("NumberMatchStatus:: $NumberMatchStatus");

  }




  readGiveFix2(String id_job) async{
    print("readGiveFix2:: $id_job");

    if (GiveFix2Models.length != 0) {
      GiveFix2Models.clear();
    } else {

    }

    String showGiveFix2 = '${MyConstant.domain}/repairer_app/getGiveFix2WhereIdJob.php?isAdd=true&id_job=$id_job';
    await Dio().get(showGiveFix2).then((value) {
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
          give_fix2_Model model = give_fix2_Model.fromMap(item);
          //print('detail ==>> ${model.identifySymptoms}');
          print('id3:: ${model.id}');
          print('date1_3:: ${model.date1}');
          print('time1_3:: ${model.time1}');
          print('typeRepairer3:: ${model.typeRepairer}');
          print('identifySymptoms3:: ${model.identifySymptoms}');
          print('address1_3:: ${model.address1}');
          print('image3:: ${model.image}');
          print('lat3:: ${model.lat}');
          print('lng3:: ${model.lng}');
          print('order_fix3:: ${model.order_fix}');
          print('id_job3:: ${model.id_job}');
          print('dateMeet3:: ${model.dateMeet}');
          print('timeMeet3:: ${model.timeMeet}');
          //readJobStatus(model.id_job);

          setState(() {
            //load = false;
            //haveData = true;
            GiveFix2Models.add(model);
          });
        }

      }
    });
  }


  readUserModel(String idCustomer) async{
    print("readUserModel:: $idCustomer");

    if (UserModel_Models.length != 0) {
      UserModel_Models.clear();
    } else {

    }

    String showUserCustomer = '${MyConstant.domain}/repairer_app/getUserWhereId.php?isAdd=true&id=$idCustomer';
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
            UserModel_Models.add(model);
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

  stringtoInt(String text){
    var num = int.parse(text);
    return num;
  }

  firstnameWithIdCustomer(String idCustomer){
    String firstname = "nonFirstName";
    for(int i = 0;i<UserModel_Models.length;i++){
      if(UserModel_Models[i].id == idCustomer){
        firstname = UserModel_Models[i].firstname;
        break;
      }
    }
    return firstname;
  }
  lastnameWithIdCustomer(String idCustomer){
    String lastname = "nonFirstName";
    for(int i = 0;i<UserModel_Models.length;i++){
      if(UserModel_Models[i].id == idCustomer){
        lastname = UserModel_Models[i].lastname;
        break;
      }
    }
    return lastname;
  }

  dateMeetWithIdJob(String id_job){
    String dateMeet = "nondateMeet";
    for(int i = 0;i<GiveFix2Models.length;i++){
      if(GiveFix2Models[i].id_job == id_job){
        dateMeet = GiveFix2Models[i].dateMeet;
        break;
      }
    }
    return dateMeet;
  }

  timeMeetWithIdJob(String id_job){
    String timeMeet = "nontimeMeet";
    for(int i = 0;i<GiveFix2Models.length;i++){
      if(GiveFix2Models[i].id_job == id_job){
        timeMeet = GiveFix2Models[i].timeMeet;
        break;
      }
    }
    return timeMeet;
  }

  identifySymptomsWithIdJob(String id_job){
    String identifySymptoms = "nonIdentifySymptoms";
    for(int i = 0;i<GiveFix2Models.length;i++){
      if(GiveFix2Models[i].id_job == id_job){
        identifySymptoms = GiveFix2Models[i].identifySymptoms;
        break;
      }
    }
    return identifySymptoms;
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
    //SetMatchJobStatus();

    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: load
          ? ShowProgress()
          : haveData!
          ? LayoutBuilder(
          builder: (context, constraints) => buildListView(constraints))
          : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTitle(
                  title: 'ยังไม่มีงานซ่อมที่ตอบรับแล้ว',
                  textStyle: MyConstant().h1BlackStyle()),
              ShowTitle(
                  title: 'เมื่อมีงานซ่อมที่ตอบรับแล้วจะแสดงที่่นี้',
                  textStyle: MyConstant().h2BlackStyle()),
            ],
          )),
    );
  }

  RefreshIndicator buildListView(BoxConstraints constraints) {

    //print(stringtoInt("1"));

    return RefreshIndicator(
      onRefresh: refreshPage,
      child: ListView.builder(
        itemCount: tableMatchJobModels.length,//numberMatch.length,
        itemBuilder: (context, index) => Card(
          child:// firstnameArrText.isNotEmpty && lastnameArrText.isNotEmpty && dateMeetArrText.isNotEmpty && timeMeetArrText.isNotEmpty && identifySymptomsText.isNotEmpty && statusText.isNotEmpty ?
          //statusWithIdJob(tableMatchJobModels[index].id_job) == "match" ?
          statusWithIdJob(tableMatchJobModels[index].id_job) != "wait_repairer" ?
          Row(
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
                          //firstname+lastname
                          Text(
                            //tableMatchJobModels[index].id_customer +
                              firstnameWithIdCustomer(tableMatchJobModels[index].id_customer)+' '+lastnameWithIdCustomer(tableMatchJobModels[index].id_customer) ,
                            //NumberMatchStatus[index].toString() +
                            //    UserModel_Models[NumberMatchStatus[index]].firstname.toString()+' '+UserModel_Models[NumberMatchStatus[index]].lastname.toString(),
                            //firstnameArrText[numberMatch[index]]+' '+lastnameArrText[numberMatch[index]],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),

                          // ไปหน้าdetail การซ่อม
                          IconButton(
                            onPressed: () {
                              print('## click Detail');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowDetailMyJob(
                                        statusWithIdJob(tableMatchJobModels[index].id_job) ,
                                        tableMatchJobModels[index],
                                        //add boom
                                        servicecustomerModels,
                                        jobStatusModelModels,
                                        GiveFix2Models,
                                        UserModel_Models,
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

                      //วันที่และเวลาที่นัดช่าง
                      Text(
                        dateMeetWithIdJob(tableMatchJobModels[index].id_job)+' | '+timeMeetWithIdJob(tableMatchJobModels[index].id_job),
                        //'',
                        //GiveFix2Models[NumberMatchStatus[index]].dateMeet.toString() + ' | ' + GiveFix2Models[NumberMatchStatus[index]].timeMeet.toString(),
                        //dateMeetArrText[numberMatch[index]] + ' | ' + timeMeetArrText[numberMatch[index]],
                        style: MyConstant().h4Style(),
                      ),
                      Text(
                        identifySymptomsWithIdJob(tableMatchJobModels[index].id_job),
                        //GiveFix2Models[NumberMatchStatus[index]].identifySymptoms.toString(),
                        //identifySymptomsText[numberMatch[index]],
                        style: MyConstant().h4Style(),
                      ),
                      Text(
                        'สถานะ'+ ' '+statusWithIdJob(tableMatchJobModels[index].id_job),
                        //'สถานะ'+ ' ' +jobStatusModelModels[NumberMatchStatus[index]].status_work.toString(),
                        //'สถานะ' + ' ' + statusText[numberMatch[index]],
                        style: MyConstant().h3BlackStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ):Row()
        ),
      ),
    );
  }

}