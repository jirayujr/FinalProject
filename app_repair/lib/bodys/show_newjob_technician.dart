import 'dart:convert';

import 'package:app_repair/backend/backend.dart';
import 'package:app_repair/bodys/show_detail_service_technician.dart';
import 'package:app_repair/bodys/show_detail_service_customer.dart';
import 'package:app_repair/models/give_fix2_Model.dart';
import 'package:app_repair/models/jobStatusModel.dart';
import 'package:app_repair/models/send_table_match_job.dart';
import 'package:app_repair/models/service_customer.dart';
import 'package:app_repair/models/user_model.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_repair/backend/backend.dart';
import 'dart:io';
//import 'package:path_provider/path_provider.dart';


class ShowNewJob extends StatefulWidget {
  const ShowNewJob({Key? key}) : super(key: key);

  @override
  _ShowCurrentJobState createState() => _ShowCurrentJobState();
}

class _ShowCurrentJobState extends State<ShowNewJob> {
  bool load = true;
  bool? haveData;
  List<tableMatchJob> tableMatchJobModels = [];
  List<jobStatusModel> jobStatusModelModels = [];
  List<UserModel> UserModel_Models = [];
  List<give_fix2_Model> GiveFix2Models = [];
  List<ServiceCustomer> servicecustomerModels = [];





  String idJobArr = "";

  String keyFirstname = "";
  String keyLastname = "";
  String keyDateMeet = "";
  String keyTimeMeet = "";
  String keyIdentifySymptoms = "";

  List<String> firstnameArrText = [];
  List<String> lastnameArrText = [];
  List<String> dateMeetArrText = [];
  List<String> timeMeetArrText = [];
  List<String> identifySymptomsText = [];
  List<String> statusText = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readMybooking();
  }

  Future<Null>refreshPage()async{
    readMybooking();

  }
/*
  readJsonFirstnameNewJobAll() async {
    String text = "";
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonFirstnameNewJob.json');
    text = await file.readAsString();
    print("textTest:: $text");
    Map<String, dynamic> textKey = jsonDecode(text);    //print(text);

    setState(() {
      for(int i = 0;i< textKey.length;i++){
        firstnameArrText.add(textKey["$i"]);
      }
    });
    print("readJsonFirstnameNewJobAll:: $firstnameArrText");
  }

  Future<void> writeJsonFirstnameNewJob(String textFile) async{
    print("writeJsonFirstnameNewJob:: $textFile");
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonFirstnameNewJob.json');
    await file.writeAsString(textFile);
  }

  readJsonLastnameNewJobAll() async {
    String text = "";
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonLastnameNewJob.json');
    text = await file.readAsString();
    print("textTestreadJsonLastnameNewJobAll:: $text");
    Map<String, dynamic> textKey = jsonDecode(text);    //print(text);

    setState(() {
      for(int i = 0;i< textKey.length;i++){
        lastnameArrText.add(textKey["$i"]);
      }
    });
    print("readJsonLastnameNewJobAll:: $lastnameArrText");
  }

  Future<void> writeJsonLastnameNewJob(String textFile) async{
    print("writeJsonLastnameNewJob:: $textFile");
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonLastnameNewJob.json');
    await file.writeAsString(textFile);
  }

  readJsonDateMeetNewJobAll() async {
    String text = "";
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonDateMeetNewJob.json');
    text = await file.readAsString();
    print("textTestReadJsonDateMeetNewJobAll:: $text");
    Map<String, dynamic> textKey = jsonDecode(text);    //print(text);

    setState(() {
      for(int i = 0;i< textKey.length;i++){
        dateMeetArrText.add(textKey["$i"]);
      }
    });
    print("readJsonDateMeetNewJobAll:: $dateMeetArrText");
  }

  Future<void> writeJsonDateMeetNewJob(String textFile) async{
    print("writeJsonDateMeetNewJob:: $textFile");
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonDateMeetNewJob.json');
    await file.writeAsString(textFile);
  }

  readJsonTimeMeetAll() async {
    String text = "";
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonTimeMeetNewJob.json');
    text = await file.readAsString();
    print("textTestReadJsonTimeMeetAll:: $text");
    Map<String, dynamic> textKey = jsonDecode(text);    //print(text);

    setState(() {
      for(int i = 0;i< textKey.length;i++){
        timeMeetArrText.add(textKey["$i"]);
      }
    });
    print("readJsonTimeMeetAll:: $timeMeetArrText");
  }

  Future<void> writeJsonTimeMeetNewJob(String textFile) async{
    print("writeJsonTimeMeetNewJob:: $textFile");
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonTimeMeetNewJob.json');
    await file.writeAsString(textFile);
  }

  readIdentifySymptomsNewJob() async {
    String text = "";
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonIdentifySymptomsNewJob.json');
    text = await file.readAsString();
    print("textTestReadJsonTimeMeetAll:: $text");
    Map<String, dynamic> textKey = jsonDecode(text);    //print(text);

    setState(() {
      for(int i = 0;i< textKey.length;i++){
        identifySymptomsText.add(textKey["$i"]);
      }
    });
    print("identifySymptomsText:: $identifySymptomsText");
  }

  Future<void> writeJsonIdentifySymptomsNewJob(String textFile) async{
    print("writeJsonIdentifySymptomsNewJob:: $textFile");
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonIdentifySymptomsNewJob.json');
    await file.writeAsString(textFile);
  }

  readJsonStatusNewJob() async {
    String text = "";
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonStatusNewJob.json');
    text = await file.readAsString();
    print("textTestReadJsonStatusNewJob:: $text");
    Map<String, dynamic> textKey = jsonDecode(text);    //print(text);

    setState(() {
      for(int i = 0;i< textKey.length;i++){
        statusText.add(textKey["$i"]);
      }
    });
    print("readJsonStatusNewJob:: $statusText");
  }

  //writeJsonStatusNewJob
  Future<void> writeJsonStatusNewJob(String textFile) async{
    print("writeJsonStatusNewJob:: $textFile");
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonStatusNewJob.json');
    await file.writeAsString(textFile);
  }
  */

  Future<Null> readMybooking() async {
    if (tableMatchJobModels.length != 0) {
      tableMatchJobModels.clear();
    } else {}

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

/*
  Future<void> showIdJobTableMatchJob()async {
    backend obj = new backend();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    String  textRepairer = await obj.showIdJobRepairer(id!);
    print("IdJobRepair:: $textRepairer");
  }
  */


  firstnameWithIdCustomer(String idCustomer){
    String firstname = "nonFirstname";
    for(int i = 0;i<UserModel_Models.length;i++){
      if(UserModel_Models[i].id == idCustomer){
        firstname = UserModel_Models[i].firstname;
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



    /*
    if(firstnameArrText.isEmpty && lastnameArrText.isEmpty && dateMeetArrText.isEmpty && timeMeetArrText.isEmpty && identifySymptomsText.isEmpty && statusText.isEmpty) {
      writeAllJsonNewJobTechnician();
      readJsonFirstnameNewJobAll();
      readJsonLastnameNewJobAll();
      readJsonDateMeetNewJobAll();
      readJsonTimeMeetAll();
      readIdentifySymptomsNewJob();
      readJsonStatusNewJob();
    }else{
      print("some type ArrTextArrEmpty");
    }
    */

    return Scaffold(

      backgroundColor: Colors.orange.shade100,
      body: load
          ? ShowProgress()
          : haveData! && tableMatchJobModels.isNotEmpty
          ?  LayoutBuilder(
          builder: (context, constraints) => buildListView(constraints))
          : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTitle(
                  title: 'ยังไม่มีงานซ่อมเข้ามาใหม่',
                  textStyle: MyConstant().h1BlackStyle()),
              ShowTitle(
                  title: 'เมื่อมีงานซ่อมเข้ามาใหม่จะแจ้งเตือนที่่นี้',
                  textStyle: MyConstant().h2BlackStyle()),
            ],
          )),
    );
  }

  RefreshIndicator buildListView(BoxConstraints constraints) {

    /*
    if(firstnameArrText.isEmpty) {
      readJsonFirstnameNewJobAll();
    }else{
      print("firstNameArrTextArrEmpty");
    }
    */

    //writeJson1("1","13202226024");
    //readJsonPath();
    //print("ovo");
    //print(tableMatchJobModels[0].id_customer);
    //backend obj = new backend();
    //obj.showFirstName(tableMatchJobModels[0].id_customer);

    /*showIdJobTableMatchJob();
    print("keyFirstname:: $keyFirstname");
    print("keyLastname:: $keyLastname");
    print("keyDateMeet:: $keyDateMeet");
    print("keyTimeMeet:: $keyTimeMeet");
    print("keyIdentifySymptoms:: $keyIdentifySymptoms");*/

    //String textTestIdCustomer = tableMatchJobModels[0].id_customer;

    /*
    List<String> tableMatchJobCustomerModelsIdCustomerArr = [];
    List<String> tableMatchJobCustomerIdJobArr = [];
    List<String> userFirstnameArr = [];
    List<String> userLastnameArr = [];
    List<String> giveFixDateMeet = [];
    List<String> giveFixTimeMeet = [];
    List<String> giveFixIdentifySymptoms = [];




    for(int i = 0;i < tableMatchJobModels.length;i++){
      tableMatchJobCustomerModelsIdCustomerArr.add(tableMatchJobModels[i].id_customer);
      tableMatchJobCustomerIdJobArr.add(tableMatchJobModels[i].id_job);
      //writeJson1(tableMatchJobCustomerModelsIdCustomerArr[i], tableMatchJobCustomerIdJobArr[i]);
      //readJsonPath();
      print(tableMatchJobCustomerModelsIdCustomerArr[i]);
      print(tableMatchJobCustomerIdJobArr[i]);
      writeJson1(tableMatchJobCustomerModelsIdCustomerArr[i], tableMatchJobCustomerIdJobArr[i]);
      readJsonPath();
      print(":ww::$keyFirstname");
    }
    */

    return RefreshIndicator(
      onRefresh: refreshPage,
      child: ListView.builder(
        itemCount:  tableMatchJobModels.length,
        itemBuilder: (context, index) => Card(
          child: //firstnameArrText.isNotEmpty && lastnameArrText.isNotEmpty && dateMeetArrText.isNotEmpty && timeMeetArrText.isNotEmpty && identifySymptomsText.isNotEmpty && statusText.isNotEmpty ?
          tableMatchJobModels.isNotEmpty && UserModel_Models.isNotEmpty && GiveFix2Models.isNotEmpty && jobStatusModelModels.isNotEmpty &&
          statusWithIdJob(tableMatchJobModels[index].id_job) == "wait_repairer" ?
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
                            firstnameWithIdCustomer(tableMatchJobModels[index].id_customer)+' '+lastnameWithIdCustomer(tableMatchJobModels[index].id_customer),
                            //UserModel_Models[index].firstname.toString()+' '+UserModel_Models[index].lastname.toString(),
                                //firstnameArrText[index]+' '+lastnameArrText[index], //+'ใส่ชื่อ+นามสกุลูกค้า',
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
                                    builder: (context) => ShowDetailJobTechnician(
                                      //"",
                                     // tableMatchJobModels[index]
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
                          //GiveFix2Models[index].dateMeet+ ' | '+GiveFix2Models[index].timeMeet,
                        //dateMeetArrText[index]+ ' | ' +timeMeetArrText[index],//+'ใส่วันที่' + ' | ' + 'ใส่เวลา',
                        style: MyConstant().h4Style(),
                      ),
                      Text(
                        identifySymptomsWithIdJob(tableMatchJobModels[index].id_job),
                        //identifySymptomsText[index],//+'ใส่อาการ',
                        style: MyConstant().h4Style(),
                      ),
                      Text(
                        'สถานะ' + ' '+statusWithIdJob(tableMatchJobModels[index].id_job),
                        //'สถานะ' + ' '+statusText[index], //+ 'สถานะ' + ' ' + '(ใส่ค่าสถานะ)',
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

  /*
  Future<void> writeAllJsonNewJobTechnician() async {
    //List<String> idRepairerArr = [];
    //List<String> idJobArr = [];
    //String textFirstName = 'nonValue';
    //String textLastName = 'nonValue';
    //String textDateMeet = 'nonValue';
    //String textTimeMeet = 'nonValue';
    //String textIdentifySymptoms = 'nonValue';


    backend obj = new backend();
    List<String> firstNameArr = [];
    List<String> lastNameArr = [];
    List<String> dateMeetArr = [];
    List<String> timeMeetArr = [];
    List<String> identifySympotomsArr = [];
    List<String> statusArr = [];



    for(int i = 0;i < tableMatchJobModels.length;i++){
      //idRepairerArr.add(tableMatchJobModels[i].id_customer);
      //idJobArr.add(tableMatchJobModels[i].id_job);
      firstNameArr.add(await obj.showFirstName(tableMatchJobModels[i].id_customer));
      lastNameArr.add(await obj.showLastName(tableMatchJobModels[i].id_customer));
      dateMeetArr.add(await obj.showDateMeetWithIdJob(tableMatchJobModels[i].id_job));
      timeMeetArr.add(await obj.showTimeMeet(tableMatchJobModels[i].id_job));
      identifySympotomsArr.add(await obj.showIdentifySymptomsIdJob(tableMatchJobModels[i].id_job));
      statusArr.add(await obj.showStatus(tableMatchJobModels[i].id_job));
    }
    print("firstNameArr:: $firstNameArr");
    print("lastNameArr:: $lastNameArr");
    print("dateMeetArr:: $dateMeetArr");
    print("timeMeetArr:: $timeMeetArr");
    print("identifySympotomArr:: $identifySympotomsArr");

    writeJsonList(firstNameArr,lastNameArr,dateMeetArr,timeMeetArr,identifySympotomsArr,statusArr);
  }

  Future<void> writeJsonList(List<String> firstNameArr,List<String> lastNameArr,List<String> dateMeetArr,List<String> timeMeetArr,List<String> identifySympotomsArr,List<String> statusArr) async{
    String textFirstnameNewJob = await StringToJsonFormat(firstNameArr, firstNameArr.length);
    writeJsonFirstnameNewJob(textFirstnameNewJob);
    String textLastnameNewJob = await StringToJsonFormat(lastNameArr, lastNameArr.length);
    writeJsonLastnameNewJob(textLastnameNewJob);
    String textDateMeetNewJob = await StringToJsonFormat(dateMeetArr, dateMeetArr.length);
    writeJsonDateMeetNewJob(textDateMeetNewJob);
    String textDateTimeMeetNewJob = await StringToJsonFormat(timeMeetArr, timeMeetArr.length);
    writeJsonTimeMeetNewJob(textDateTimeMeetNewJob);
    String textIdentifySymptomsNewJob = await StringToJsonFormat(identifySympotomsArr, identifySympotomsArr.length);
    writeJsonIdentifySymptomsNewJob(textIdentifySymptomsNewJob);
    String textStatusNewJob = await StringToJsonFormat(statusArr, statusArr.length);
    writeJsonStatusNewJob(textStatusNewJob);
  }

  Future<String> StringToJsonFormat( List<String>  text,int sizeArr) async {
    backend obj = new backend();
    String ans = "{";
    for(int i = 0;i < sizeArr;i++){
      //String textStatus = await obj.showStatus(text[i]);
      String key = text[i];
      if(i < sizeArr - 1) {
        //String key = text[i];
        ans += '"$i":"$key",';
      }else{
        //String key = text[i];
        ans += '"$i":"$key"';
      }
    }
    ans += "}";
    print(ans);
    return ans;
  }
  */
}