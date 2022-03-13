import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:app_repair/utility/my_dialog.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_repair/widgets/show_image.dart';
import 'package:flutter/material.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:app_repair/models/user_model.dart';
import 'package:app_repair/states/authen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_repair/backend/backend.dart';
import 'package:dio/dio.dart';

//import 'package:flutter_absolute_path/flutter_absolute_path.dart';

int id = 0;
String firstname = "";
String lastname = "";
String textIdRepairer = "0";
String textTypeRepairer = "";

class SubmitService extends StatefulWidget {
  const SubmitService({Key? key}) : super(key: key);

  @override
  _SubmitServiceState createState() => _SubmitServiceState();
}

class _SubmitServiceState extends State<SubmitService> {
  DateTime _dateTime = new DateTime.now();
  TimeOfDay _timeOfDay = new TimeOfDay.now();

  final items = ['electrician', 'plumber', 'computerTechnician'];

  final formkey = GlobalKey<FormState>();
  String? value ;
  List<File?> files = [];
  File? file;
  double? lat, lng;

  String textForm = "";
  String textAddress = "";

  File? fileImage;
  List<File?> fileImageArr = [];
  String ImageFile = '';

  List<String> nameImageFixArr = ['', '', '', ''];
  List<String> ImageFileFixArr = ['', '', '', ''];

  String nameImageFix2 = '';


  defineNameNameImage(int num){
    int i = Random().nextInt(100000);
    String min = _timeOfDay.minute.toString();
    String hour = _timeOfDay.hour.toString();
    String day = _dateTime.day.toString();
    String month = _dateTime.month.toString();
    String year = _dateTime.year.toString();

    for(int i = 0;i < num;i++){
      nameImageFixArr[i] = 'imageFix$day$month$year$hour$min$i.jpg';
      String keyText = nameImageFixArr[i];
      ImageFileFixArr[i] = '/repairer_app/avatar/$keyText';
    }
    nameImageFix2 = 'imageFix$day$month$year$hour$min$i.jpg';
    ImageFile = '/repairer_app/avatar/$nameImageFix2';
  }


  Future<Null> uploadPictureAndInsertData(String nameImageText,int numFileImage) async {
    if(files[numFileImage] == null){

    }else{
      print('### process Upload image fix');
      String apiSaveAvatar =  '${MyConstant.domain}/repairer_app/saveAvatar.php';
      //int i = Random().nextInt(100000);
      //String nameImageFix = 'imageFix$i.jpg';
      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(files[numFileImage]!.path, filename: nameImageText);
      FormData data = FormData.fromMap(map);
      await Dio().post(apiSaveAvatar, data: data).then((value) {
        //ImageFile = '/repairer_app/avatar/$nameImageFix2';

      });
      ImageFile = '/repairer_app/avatar/$nameImageText';

      //ImageFile = '/repairer_app/avatar/$nameImageFix';
    }
  }

  /*
  // boom add  matchJobOrder
  matchJobOrder(String idRepairer) async {
    String LastRecord = await getLastRecord("table_match_job", "orderMatch");
    //print(LastRecord);
    int numLastRecord = int.parse(LastRecord);
    matchJob(
        id.toString(),
        idRepairer,
        SetIdJob(
            id.toString(),
            idRepairer,0
            _dateTime.year.toString(),
            _dateTime.month.toString(),
            _dateTime.day.toString(),
            _timeOfDay.hour.toString(),
            _timeOfDay.minute.toString()),
        (numLastRecord + 1).toString());
  }

  //boom add insertStatusOrder
  insertStatusOrder(String IdJob, String dateStart, String dateEnd,
      String statusWork, String orderStartDate, String orderEndDate) async {
    String LastRecondStatus = await getLastRecord("jobstatus", "order_job");
    int numLastRecondStatus = int.parse(LastRecondStatus);
    statusInsert(IdJob, dateStart, dateEnd, statusWork, orderStartDate,
        orderEndDate, (numLastRecondStatus + 1).toString());
  }

  // boom add updateStatus
  Future<String> updateRecord(String tableName, String typeName,
      String valueName, dataTypeConditionName, valueCondtionName) async {
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

  // boom add update status
  updateStatus(String status, String idJob) {
    updateRecord("jobstatus", "status_work", status, "id_job", idJob);
  }

  //
  //boom add update date_start
  updateDateStart(String date_start, String idJob) {
    updateRecord("jobstatus", "date_start", date_start, "id_job", idJob);
  }

  // boom add update date_end
  updateDateEnd(String date_end, String idJob) {
    updateRecord("jobstatus", "date_end", date_end, "id_job", idJob);
  }

  //boom add update orderStart_date
  updateOrderStartDate(String orderStart_date, String idJob) {
    updateRecord(
        "jobstatus", "orderStart_date", orderStart_date, "id_job", idJob);
  }

  //boom add update orderEnd_date
  updateOrderEndDate(String orderEnd_date, String idJob) {
    updateRecord("jobstatus", "orderEnd_date", orderEnd_date, "id_job", idJob);
  }

  //boom add delete
  Future<String> deleteRecord(
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
  Future<String> getLastRecord(String tableName, String getLastRecond) async {
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
  Future<String> jobStatus(String idJob) async {
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
  Future<String> statusInsert(
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
  SetIdJob(String idCustomer, String idRepairer, String year, String month,
      String day, String hour, String min) {
    print("$idCustomer$idRepairer$year$month$day$hour$min");
    return "$idCustomer$idRepairer$year$month$day$hour$min";
  }

//boom add example find repairer app
  Future<String> findRepairMatch(
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
  Future<void> matchJob(String idCustomer, String idRepairer, String idJob,
      String orderMatch) async {
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

// boom add to receive data
  Future<String> _getDirPath() async {
    final _dir = await getApplicationDocumentsDirectory();
    return _dir.path;
  }

  Future<void> _readDataId() async {
    //print("_readData");
    final _dirPath = await _getDirPath();
    final _myFile = File('$_dirPath/nameId.json');
    final _data = await _myFile.readAsString(encoding: utf8);
    setState(() {
      id = int.parse(_data);
    });
    print("=======readId============ $id");
  }*/

//==================================
  Future<Null> checkPermission() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      print('Service Location Open');

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // findLatLng()
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // findLatLng()
          findLatLng();
        }
      }
    } else {
      print('Service Location Close');
      MyDialog().alertLocationService(
          context, 'Location Service ปิดอยู่', ' กรุณาเปิด Location Service ');
    }
  }

  Future<Null> findLatLng() async {
    print('finadLatLan ==> Work');
    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      print('lat = $lat,lng = $lng');
    });
  }

  Future<Position?> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFile();
    checkPermission();
  }

  void initialFile() {
    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

  Future<void> getIdAuthen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? keyValue = preferences.getString('id');
    id = int.parse(keyValue!);
    firstname = preferences.getString('name')!;
    print(keyValue);
    print(id);
    print(firstname);
  }

  @override
  Widget build(BuildContext context) {
    //_readDataId();
    getIdAuthen();
    print("value:: $value");
    print("textForm:: $textForm");
    fileImage = files[0];
    defineNameNameImage(4);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('แจ้งอาการ'),
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
      backgroundColor: Colors.orange.shade100,
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () async {
                        DateTime? _newDate = await showDatePicker(
                            context: context,
                            initialDate: _dateTime,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1));
                        if (_newDate != null) {
                          setState(() {
                            _dateTime = _newDate;
                          });
                        }
                      },
                      child: Text('เลือกวันที่')),
                  buildTitle(
                      '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}'),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () async {
                        TimeOfDay? _newTime = await showTimePicker(
                          context: context,
                          initialTime: _timeOfDay,
                        );

                        if (_newTime != null) {
                          setState(() {
                            _timeOfDay = _newTime;
                          });
                        }
                      },
                      child: Text('เลือกเวลา')),
                  buildTitle('${_timeOfDay.hour}:${_timeOfDay.minute}'),
                  buildTitle2('เลือกประเภทช่าง'),
                  buildSelectTech(),
                  buildTitle2('ระบุอาการ'),
                  buildTextField(),
                  buildImage(constraints),
                  buildTitle2('ที่อยู่'),
                  buildAddress(),
                  buildTitle2('แสดงพิกัดของคุณ'),
                  buildLo(),
                  buildSubmitButton(constraints),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> processImagePicker(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );

      setState(() {
        file = File(result!.path);
        //nameFileArr[index] = result.path;
        files[index] = file;
        //fileImageArr[index] = file;
      });
    } catch (e) {}
  }

  Future<Null> chooseSourceImageDialog(int index) async {
    print('Click From index ==>> $index');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.logo),
          title: ShowTitle(
              title: 'เพิ่มรูปภาพที่ ${index + 1} ?',
              textStyle: MyConstant().h2Style()),
          subtitle: ShowTitle(
              title: 'Please Tab on Camera or Gallery',
              textStyle: MyConstant().h3Style()),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processImagePicker(ImageSource.camera, index);
                },
                child: Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processImagePicker(ImageSource.gallery, index);
                },
                child: Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildAddress() {
    return Container(
      /*margin: EdgeInsets.only(top: 16),
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 4)),
      child: TextFormField(
        maxLines: 4,
        decoration: InputDecoration(
          labelStyle: MyConstant().h3BlackStyle(),
        ),
        validator: (value1) {
          if (value1!.isEmpty) {
            print("non Value");
            return 'กรุณากรอกที่อยู่';
          } else {
            return null;
          }
        },
        onSaved: (value1){
          textAddress = value1!;
        }
      ),*/
      margin: EdgeInsets.only(top: 8),
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 4)),
      child: TextFormField(
        /*validator: (value) {
          print("validator:: $value");
          if (value!.isEmpty) {
            return 'กรุณาระบุรายละเอียด';
          } else {
            textForm = value;
            return null;
          }
        },*/
        maxLines: 4,
        decoration: InputDecoration(
          labelStyle: MyConstant().h3BlackStyle(),
          //hintText: "fuck",
        ),
        /*onSaved:(String){
          print("hello101");
        },*/
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณาระบุรายละเอียด';
          } else {
            textAddress = value;
            return null;
          }
        },
        onSaved: (value) {
          textAddress = value!;
        },
      ),
    );
  }

  Container buildSubmitButton(BoxConstraints constraints){
    String dateText = DateFormat.yMd().format(DateTime.now());
    String timeText = DateFormat.Hm().format(DateTime.now());
    String dateMeetText = DateFormat.yMd().format(_dateTime);
    String timeMeetText = "";
    String imageLink0 = ImageFileFixArr[0];
    String imageLink1 = ImageFileFixArr[1];
    String imageLink2 = ImageFileFixArr[2];
    String imageLink3 = ImageFileFixArr[3];
    String idJobText  = "";
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

    return Container(
      width: constraints.maxHeight * 0.75,
      child: ElevatedButton(
        style: MyConstant().myButtonStyle(),
        onPressed: () async {
          if (formkey.currentState!.validate()) {
          }

          //backend text = new backend();
          //text.insertJobstatus("idJob", "dateStart", "deteEnd", "statusWork", "orderStartDate", "orderEndDate");
          //text.insertJobStatusIdStatus("131999513800","busy");

          //List<String> nameArr = ['tableName','sizeArr','0','1','2','3','4','5','6','7'];
          //List<String> valueArr = ["table_match_job","10","id_customer","id_repairer","id_job","orderMatch","1","2","toyota","3"];

          /*
          backend text = new backend();
          List<String> nameArr = ['tableName','sizeArr','0','1','2','3','4','5','6','7','8','9','10','11','12','13'];
          List<String> valueArr = ["jobstatus","16","id_job","date_start","date_end","status_work","orderStart_date","orderEnd_date","order_job","120","120","120","120","120","120","120"];
          text.insertRecondBackendNonSizeArr("table_match_job",nameArr,valueArr);
           */

          for(int i = 0;i < 4;i++) {
            uploadPictureAndInsertData(nameImageFixArr[i],i);
          }
          print("elevateButton");
          print(value);
          print(textForm);
          backend key = new backend();
          if(value != null){
             if(textForm == ""){
               print("non value textForm");
             }else{
               String idRepair = await key.findRepairMatchBackend("$dateText", "$value", "$lat", "$lng", "$id");
               print("nameRepair:: "+idRepair);
               if( idRepair == "0 results"){
                 idRepair = "n";
               }else{
                 if(files.isNotEmpty) {
                   if(files[0] == null){
                     print("files[0] null");
                     imageLink0 = "";

                   }
                   if(files[1] == null){
                     print("files[1] null");
                     imageLink1 = "";
                   }
                   if(files[2] == null){
                     print("files[2] null");
                     imageLink2 = "";

                   }
                   if(files[3] == null){
                     print("files[3] null");
                     imageLink3 = "";
                   }
                 }
                 print(idRepair);
                 idJobText = key.SetIdJobBackend("$id", idRepair, DateTime.now().year.toString(), DateTime.now().month.toString(), DateTime.now().day.toString(), DateTime.now().hour.toString(), DateTime.now().minute.toString());
                 key.needFixNewOrder("$dateText", "$timeText", "$value", "$textForm", "$textAddress", "$imageLink0", "$imageLink1", "$imageLink2", "$imageLink3", "$lat", "$lng", "$id", "$idJobText", "$dateMeetText","$timeMeetText");
                 key.matchJobOrderIdJobBackend("$id",idRepair,idJobText);
                 key.insertJobStatusIdStatus(idJobText, "wait_repairer");
               }
             }
             Navigator.pop(context);

          }else{
            print("null value");
          }
        },
        child: Text('แจ้งซ่อม'),
      ),
    );
  }

  Container buildSelectTech() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(43, 8, 43, 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 4)),
      child: DropdownButton<String>(
          value: value,
          // size icon
          iconSize: 47,

          // arrow in text
          icon: Icon(
            //icons_type
            Icons.arrow_drop_down,
            //color icon
            color: Colors.black,
          ),

          isExpanded: true,
          items: items.map(buildMenuItem).toList(),
          onChanged: (value) => setState(
                () => this.value = value,
              )),
    );
  }

  Container buildTextField() {
    print("buildTextField");
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 4)),
      child: TextFormField(
        /*validator: (value) {
          print("validator:: $value");
          if (value!.isEmpty) {
            return 'กรุณาระบุรายละเอียด';
          } else {
            textForm = value;
            return null;
          }
        },*/
        maxLines: 4,
        decoration: InputDecoration(
          labelStyle: MyConstant().h3BlackStyle(),
          //hintText: "fuck",
        ),
        /*onSaved:(String){
          print("hello101");
        },*/
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณาระบุรายละเอียด';
          } else {
            textForm = value;
            return null;
          }
        },
        onSaved: (value) {
          textForm = value!;
        },
      ),
    );
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
            width: constraints.maxWidth * 0.6,
            height: constraints.maxWidth * 0.6,
            child: file == null
                ? Image.asset(MyConstant.image)
                : Image.file(file!)),
        Container(
          width: constraints.maxWidth * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                    onTap: () => chooseSourceImageDialog(0),
                    child: files[0] == null
                        ? Image.asset(MyConstant.addimage)
                        : Image.file(
                            files[0]!,
                            fit: BoxFit.cover,
                          )),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                    onTap: () => chooseSourceImageDialog(1),
                    child: files[1] == null
                        ? Image.asset(MyConstant.addimage)
                        : Image.file(
                            files[1]!,
                            fit: BoxFit.cover,
                          )),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                    onTap: () => chooseSourceImageDialog(2),
                    child: files[2] == null
                        ? Image.asset(MyConstant.addimage)
                        : Image.file(
                            files[2]!,
                            fit: BoxFit.cover,
                          )),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                    onTap: () => chooseSourceImageDialog(3),
                    child: files[3] == null
                        ? Image.asset(MyConstant.addimage)
                        : Image.file(
                            files[3]!,
                            fit: BoxFit.cover,
                          )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildTitle(String title) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 8),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2BlackStyle(),
      ),
    );
  }

  Container buildTitle2(String title) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 8),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat!, lng!),
          infoWindow:
              InfoWindow(title: 'คุณอยู่ที่นี่', snippet: 'Lat=$lat, lng=$lng'),
        ),
      ].toSet();

  Widget buildLo() => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
        height: 200,
        child: lat == null
            ? ShowProgress()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 16,
                ),
                onMapCreated: (controller) {},
                markers: setMarker(),
              ),
      );
}
