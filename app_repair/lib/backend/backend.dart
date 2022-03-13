import 'dart:convert';
import 'dart:io';
import 'package:app_repair/utility/my_dialog.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_repair/widgets/show_image.dart';
import 'package:flutter/material.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:app_repair/models/user_model.dart';
import 'package:app_repair/states/authen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class backend extends State {
  String textIdRepairer = "";

  String keyValueSend = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  // boom add  matchJobOrder
  matchJobOrderBackend(String id, String idRepairer, String year, String month,
      String day, String hour, String min) async {
    var LastRecord =
        await getLastRecordBackend("table_match_job", "orderMatch");
    //print(LastRecord);
    int numLastRecord = int.parse(LastRecord);
    matchJobBackend(
        id,
        idRepairer,
        SetIdJobBackend(id.toString(), idRepairer, year, month, day, hour, min),
        (numLastRecord + 1).toString());
  }

  matchJobOrderIdJobBackend(String id,String idRepairer,String idJob) async{
    var LastRecord = await getLastRecordBackend("table_match_job", "orderMatch");
    int numLastRecord = int.parse(LastRecord);
    matchJobBackend(id, idRepairer, idJob, (numLastRecord + 1).toString());
  }

  //boom add insertStatusOrder
  insertStatusOrderBackend(String IdJob, String dateStart, String dateEnd,
      String statusWork, String orderStartDate, String orderEndDate) async {
    String LastRecondStatus =
        await getLastRecordBackend("jobstatus", "order_job");
    int numLastRecondStatus = int.parse(LastRecondStatus);
    statusInsertBackend(IdJob, dateStart, dateEnd, statusWork, orderStartDate,
        orderEndDate, (numLastRecondStatus + 1).toString());
  }

  // boom add updateStatus
  Future<String> updateRecordBackend(String tableName, String typeName,
      String valueName,String dataTypeConditionName,String valueCondtionName) async {
    print("=getUpdateRecord=");
    var url = '${MyConstant.domain}/repairer_app/UpdateDataMySql1.php';
    //print(await http.read(Uri.parse(url)));
    //data send to php
    var data = {
      'table': tableName,
      'dataType': typeName,
      'dataValue': valueName,
      'dataTypeCondtion': dataTypeConditionName,
      'valueConditon': valueCondtionName
    };

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    print(await http.read(Uri.parse(url)));

    // check value
    var textMessage = response.body;
    String text = textMessage; // set string text
    print(text);
    return text;
  }


  Future<String> updateDetailMyjob(String valueCondtionName) async {
    print("=getUpdateRecord=");
    var url = '${MyConstant.domain}/repairer_app/UpdateDataMySqlShowDetailMyJob.php';
    //print(await http.read(Uri.parse(url)));
    //data send to php
    var data = {
      'valueConditon': valueCondtionName
    };

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    print(await http.read(Uri.parse(url)));

    // check value
    var textMessage = response.body;
    String text = textMessage; // set string text
    print(text);
    return text;
  }


  // boom add update status
  updateStatusBackend(String status, String idJob) {
    updateRecordBackend("jobstatus", "status_work", status, "id_job", idJob);
  }

  //
  //boom add update date_start
  updateDateStartBackend(String date_start, String idJob) {
    updateRecordBackend("jobstatus", "date_start", date_start, "id_job", idJob);
  }

  // boom add update date_end
  updateDateEndBackend(String date_end, String idJob) {
    updateRecordBackend("jobstatus", "date_end", date_end, "id_job", idJob);
  }

  //boom add update orderStart_date
  updateOrderStartDateBackend(String orderStart_date, String idJob) {
    updateRecordBackend(
        "jobstatus", "orderStart_date", orderStart_date, "id_job", idJob);
  }

  //boom add update orderEnd_date
  updateOrderEndDateBackend(String orderEnd_date, String idJob) {
    updateRecordBackend(
        "jobstatus", "orderEnd_date", orderEnd_date, "id_job", idJob);
  }

  //boom add delete
  Future<String> deleteRecordBackend(
      String tableName, String typeName, String valueName) async {
    print("=getdeleteRecord=");
    var url = '${MyConstant.domain}/repairer_app/deleteDataMySql1.php';
    //print(await http.read(Uri.parse(url)));
    //data send to php
    var data = {
      'tableName': tableName,
      'typeName': typeName,
      'valueName': valueName
    };

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    print(await http.read(Uri.parse(url)));

    // check value
    var textMessage = response.body;
    String text = textMessage; // set string text
    print(text);
    return text;
  }

  // boom add get last record
  Future<String> getLastRecordBackend(
      String tableName, String getLastRecond) async {
    print("=getLastRecord=");
    var url = '${MyConstant.domain}/repairer_app/getLastRecond.php';
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

  // boom add create status update
  Future<String> jobStatusBackend(String idJob) async {
    //print("=jobStatus=");
    //url where php
    var url = '${MyConstant.domain}/repairer_app/job_status.php';
    //print(await http.read(Uri.parse(url)));
    //data send to php
    var data = {'id_job': idJob};

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    //print(await http.read(Uri.parse(url)));

    // check value
    var textMessage = response.body;
    String text = textMessage; // set string text
    //print(text);
    return text;
  }

  // boom add create status insert
  Future<String> statusInsertBackend(
      String IdJob,
      String dateStart,
      String dateEnd,
      String statusWork,
      String orderStartDate,
      String orderEndDate,
      String orderJob) async {
    //url where php
    var url = '${MyConstant.domain}/repairer_app/statusInsert.php';
    //print(await http.read(Uri.parse(url)));
    //data send to php
    var data = {
      'id_job': IdJob,
      'date_start': dateStart,
      'date_end': dateEnd,
      'status_work': statusWork,
      'orderStart_date': orderStartDate,
      'orderEnd_date': orderEndDate,
      'order_job': orderJob
    };

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    //print(await http.read(Uri.parse(url)));

    // check value
    var textMessage = response.body;
    String text = textMessage; // set string text
    print(text);
    return text;
  }

  //boom add create idJob
  SetIdJobBackend(String idCustomer, String idRepairer, String year,
      String month, String day, String hour, String min) {
    print("$idCustomer$idRepairer$year$month$day$hour$min");
    return "$idCustomer$idRepairer$year$month$day$hour$min";
  }

//boom add example find repairer app
  Future<String> findRepairMatchBackend(
      String date, String value, String lat, String lng, String id) async {
    //String matchStatus = "non match";

    //url where php
    var url = '${MyConstant.domain}/repairer_app/matchRepairer.php';
    //print(await http.read(Uri.parse(url)));
    //data send to php
    var data = {
      'date': date,
      'typeRepairer': value,
      'lat': lat,
      'lng': lng,
      'id': id
    };

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    //print(await http.read(Uri.parse(url)));

    // check value
    var textMessage = response.body;
    String text = textMessage; // set string text
    print(text);
    textIdRepairer = text;
    print("textIdRepairer:: $textIdRepairer");
    return text;
  }



  //boom add example match job
  Future<void> matchJobBackend(String idCustomer, String idRepairer,
      String idJob, String orderMatch) async {
    //String matchStatus = "non match";
    print("matchJob");
    //url where php
    var url = '${MyConstant.domain}/repairer_app/matchJob.php';
    //print(await http.read(Uri.parse(url)));
    //data send to php
    var data = {
      'idCustomer': idCustomer,
      'idRepairer': idRepairer,
      'idJob': idJob,
      'orderMatch': orderMatch
    };

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    // check value0

    var textMessage = response.body;
    String text = textMessage; // set string text
    print(text);
  }




  /*
  Future<void> readJsonPath() async {
    String text = "";
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/valuePath.json');
    text = await file.readAsString();
    Map<String, dynamic> textKey = jsonDecode(text);    //print(text);
    print(textKey["keyValue"]);
    setState(() {
      keyValueSend= textKey["firstname"];
    });
  }

  String giveValueFromFuture(Future<String> valueText){
    writeJsonFromFuture(valueText);
    readJsonPath();
    return keyValueSend;
  }*/

  Future<String> showTimeMeet(String id_job) async{
    String text = await selectRecondBackend(
        "give_fix2", "timeMeet", "id_job", id_job);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showDateMeetWithIdJob(String id_job) async{
    String text = await selectRecondBackend(
        "give_fix2", "dateMeet", "id_job", id_job);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showTimeMeetWithIdJob(String id_job) async{
    String text = await selectRecondBackend(
        "give_fix2", "timeMeet", "id_job", id_job);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showStatusRepairerFind(String idRepairer) async {
    String text = await selectRecondBackend(
        "table_find_repaierer", "status_repairer", "id_repairer", idRepairer);
    print("=================");
    print(text);
    return text;
  }


  Future<String> showIdRepairerFromJob(String idJob) async {
    String text = await selectRecondBackend(
        "table_match_job", "id_repairer", "id_job", idJob);
    print("=================");
    print(text);
    return text;
  }


  Future<String> showIdRepairer(String id) async {
    String text = await selectRecondBackend(
        "table_match_job", "id_repairer", "id_customer", id);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showIdJobRepairer(String id) async {
    String text = await selectRecondBackend(
        "table_match_job", "id_job", "id_repairer", id);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showIdJob(String id) async {
    String text = await selectRecondBackend(
        "table_match_job", "id_job", "id_customer", id);
    print("=================");
    print(text);
    return text;
  }



  Future<String> showTypeUser(String id) async {
    String text = await selectRecondBackend(
        "user", "type", "id", id);
    print("=================");
    print(text);
    return text;
  }


  Future<String> showTypeRepair(String idCustomer) async {
    String text = await selectRecondBackend(
        "give_fix2", "TypeRepairer", "id", idCustomer);
    print("=================");
    print(text);
    return text;
  }


  Future<String> showIdentifySymptomsIdJob(String id_job) async {
    String text = await selectRecondBackend(
        "give_fix2", "identifySymptoms", "id_job", id_job);
    print("=================");
    print(text);
    return text;
  }


  Future<String> showIdentifySymptoms(String idCustomer) async {
    String text = await selectRecondBackend(
        "give_fix2", "identifySymptoms", "id", idCustomer);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showDateMeet(String idJob) async {
    String text =
        await selectRecondBackend("job_detail", "date_meet", "id_job", idJob);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showStatus(String idJob) async {
    String text =
        await selectRecondBackend("jobstatus", "status_work", "id_job", idJob);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showFirstName(String idUser) async {
    String text = await selectRecondBackend("user", "firstname", "id", idUser);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showLastName(String idUser) async {
    String text = await selectRecondBackend("user", "lastname", "id", idUser);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showAddressGiveFixIdJob(String id_job) async {
    String text = await selectRecondBackend("give_fix2", "address1", "id_job", id_job);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showAddressTableUser(String idUser) async {
    String text = await selectRecondBackend("user", "address", "id", idUser);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showPhone(String idUser) async {
    String text = await selectRecondBackend("user", "phone", "id", idUser);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showAvatar(String idUser) async {
    String text = (await selectRecondBackend("user", "avatar", "id", idUser));
    print("=================");
    print(text);
    return text;
  }

  Future<String> showImageItemFix(String idUser) async {
    String text = await selectRecondBackend("give_fix2", "image", "id", idUser);
    print("=================");
    print(text);
    return text;
  }

  Future<String> showImageItemFixWithIdJob(String idJob) async {
    String text = await selectRecondBackend("give_fix2", "image", "id_job", idJob);
    print("=================");
    print(text);
    return text;
  }

  Future<String> selectRecondBackend(String tableName, String selectName,
      String typeCondition, String valueCondition) async {
    String ans = "";
    print("=selectBackend=");
    var url = '${MyConstant.domain}/repairer_app/selectDataMySql.php';
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

  insertJobStatusIdStatus(String idJob,String statusWork){
    insertJobstatus("$idJob", "nonValue", "nonValue", "$statusWork", "nonValue", "nonValue");
  }

  insertJobstatus(String idJob,String dateStart,String deteEnd,String statusWork,String orderStartDate,String orderEndDate) async {
    String num = await getLastRecordBackend("jobstatus", "order_job");
    print(num);
    int keyNum = int.parse(num) + 1;
    num = keyNum.toString();
    List<String> nameArr = ['tableName','sizeArr','0','1','2','3','4','5','6','7','8','9','10','11','12','13'];
    List<String> valueArr = ["jobstatus","16","id_job","date_start","date_end","status_work","orderStart_date","orderEnd_date","order_job","$idJob","$dateStart","$deteEnd","$statusWork","$orderStartDate","$orderEndDate","$num"];
    insertRecondBackendNonSizeArr("table_match_job",nameArr,valueArr);
  }

  insertReviewPerson(String id_customer,String id_repairer,String score_star,String text_recommand,String id_job) async {
    String status_review = "finish_review";
    print("insertReviewPerson");
    String num = await getLastRecordBackend("review_person", "order_person");
    print(num);
    int keyNum = int.parse(num) + 1;
    num = keyNum.toString();

    List<String> nameArr = ['tableName','sizeArr','0','1','2','3','4','5','6','7','8','9','10','11','12','13'];
    List<String> valueArr = ["review_person","16","id_repairer","id_customer","score_star","text_recommend","order_person","id_job","status_review","$id_repairer","$id_customer","$score_star","$text_recommand","$num","$id_job","$status_review"];
    insertRecondBackendNonSizeArr("review_person",nameArr,valueArr);
  }

  insertRecondBackendNonSizeArr(
      String tableName, List<String> arrType, List<String> arrValue) async {
    if (arrValue.length == arrType.length) {
      insertRecondBackend(tableName, arrType.length, arrType, arrValue);
    }
  }

  insertRecondBackend(String tableName, int numArr, List<String> arrType,
      List<String> arrValue) async {
    String ans = "";
    // /*var dataKey = "{";
    // int numArr = arrType.length + 1 +arrValue.length;
    // String numArrText = numArr.toString();
    // dataKey += "'sizeArr': ";
    // dataKey += '"$numArr",';

    // for(int i = 0; i < arrType.length;i++){
    //   String ans = arrType[i];
    //   //data += "'$i' : $ans,";
    //   dataKey += " '$i': ";
    //   dataKey += '"$ans",';
    //   /*String key = arrType[i];
    //   String ans = arrValue[i];
    //   if(i == 0){
    //     data += "$key : $ans,";
    //   }else {
    //     if(i < (numArr - 1)) {
    //       data += "$key : $ans,";
    //     }else if ( i == (numArr - 1)){
    //       data += "$key : $ans";
    //     }
    //   }
    //   print(data);*/
    // }

    // for(int i = 0; i <  arrValue.length;i++){
    //   int numkey  = i + arrType.length;
    //   String ans2 =  arrValue[i];
    //   //data += " '$numkey' : $ans2,";

    //   if(i < (arrValue.length - 1)) {
    //     dataKey += " '$numkey':";
    //     dataKey += ' "$ans2",';
    //   }else{
    //     dataKey += " '$numkey':";
    //     dataKey += ' "$ans2"';
    //   }

    //   /*String key = arrType[i];
    //   String ans = arrValue[i];
    //   if(i == 0){
    //     data += "$key : $ans,";
    //   }else {
    //     if(i < (numArr - 1)) {
    //       data += "$key : $ans,";
    //     }else if ( i == (numArr - 1)){
    //       data += "$key : $ans";
    //     }
    //   }
    //   print(data);*/
    // }
    // dataKey += "}";
    // print(dataKey);
    // User  dataKeyJson = jsonDecode(dataKey);
    // print(dataKeyJson);*/
    //List<String> nameArr = ['tableName','sizeArr','0','1','2','3','4','5','6','7'];
    //List<String> valueArr = ["table_match_job","10","id_customer","id_repairer","id_job","orderMatch","1","2","toyota","3"];
    var dataKey = toJson(arrType, arrValue);
    print(dataKey);
    //var data = {'sizeArr': "9",'0': "id_customer",'1':"id_repairer",'2': "id_job",'3':"orderMatch",'4': "1",'5': "2",'6':"toyota",'7': "3"};
    //print(data);

    var url = '${MyConstant.domain}/repairer_app/insertDB.php';
    var response = await http.post(Uri.parse(url), body: json.encode(dataKey));
    var textMessage = response.body;
    ans = textMessage;
    print(ans);

    //print(arrType);
    //print(arrValue);
  }

  // insert data cancel customer repairTable
  insertCancelCustomerRepairerTable(String id_customer,String id_repairer,String type_repairer,String status_cancel,String day_cancel,String month_cancel,String year_cancel) async{
    print("hello_insertCancelCustomerRepairerTable");
    String num = await getLastRecordBackend("table_cancel_customer_repairer", "order_cancel");
    print("lastCancel:: "+ num);
    int keyNum = int.parse(num) + 1;
    num = keyNum.toString();
    List<String> nameArr = ['tableName','sizeArr','0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15'];
    List<String> valueArr = ["table_cancel_customer_repairer","18","id_customer","id_repairer","type_repairer","status_cancel","order_cancel","day_cancel","month_cancel","year_cancel","$id_customer","$id_repairer","$type_repairer","$status_cancel","$num","$day_cancel","$month_cancel","$year_cancel"];

    insertRecondBackendNonSizeArr("table_cancel_customer_repairer",nameArr,valueArr);
  }

  Map<String, dynamic> toJson(List<String> typeName, List<String> typeValue) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['name'] = name;
    //data['age'] = age;
    for (int i = 0; i < typeName.length; i++) {
      String keyType = typeName[i];
      data['$keyType'] = typeValue[i];
    }
    return data;
  }

  Future<String> needFixNew(
      String date1,
      String time1,
      String typeRepairer,
      String identifySympotoms,
      String address1,
      String image0,
      String image1,
      String image2,
      String image3,
      String lat,
      String lng,
      String id,
      String orderFix,
      String idJob) async {
    String ans = "";
    print("=needFixNew=");
    var url = '${MyConstant.domain}/repairer_app/needFix.php';
    var data = {
      'date1': date1,
      'time1': time1,
      'typeRepairer': typeRepairer,
      'identifySymptoms': identifySympotoms,
      'address1': address1,
      'image0': image0,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'lat': lat,
      'lng': lng,
      'id': id,
      'orderFix': orderFix,
      'idJob': idJob
    };
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    var textMessage = response.body;
    ans = textMessage;
    print(ans);
    return ans;
  }

  needFixNewOrder(
      String date1,
      String time1,
      String typeRepairer,
      String identifySympotoms,
      String address1,
      String image0,
      String image1,
      String image2,
      String image3,
      String lat,
      String lng,
      String id,
      String idJob,
      String dateMeet,
      String timeMeet) async {
    String ans = "";
    String orderFix = await getLastRecordBackend("give_fix2", "order_fix");
    int orderFixNumAdd = int.parse(orderFix) + 1;
    print("=needFixNew=");
    var url = '${MyConstant.domain}/repairer_app/needFix.php';
    var data = {
      'date1': date1,
      'time1': time1,
      'typeRepairer': typeRepairer,
      'identifySymptoms': identifySympotoms,
      'address1': address1,
      'image0': image0,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'lat': lat,
      'lng': lng,
      'id': id,
      'orderFix': orderFixNumAdd,
      'idJob': idJob,
      'dateMeet':dateMeet,
      'timeMeet':timeMeet,
    };
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    var textMessage = response.body;
    ans = textMessage;
    print(ans);
    return ans;
  }
}
