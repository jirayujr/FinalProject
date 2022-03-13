import 'package:app_repair/backend/backend.dart';
import 'package:app_repair/models/give_fix2_Model.dart';
import 'package:app_repair/models/jobStatusModel.dart';
import 'package:app_repair/models/send_table_match_job.dart';
import 'package:app_repair/models/service_customer.dart';
import 'package:app_repair/models/user_model.dart';
import 'package:app_repair/states/submit_service_customer.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:path_provider/path_provider.dart';

class ShowDetailMyJob extends StatefulWidget {
  late final tableMatchJob tableMatchJobModels;
  late final String textStatus;
  late final List<ServiceCustomer> servicecustomerModels;
  late final List<jobStatusModel> jobStatusModelModels;
  late final List<give_fix2_Model> GiveFix2Models;
  late final List<UserModel> UserModel_Models;





  ShowDetailMyJob(this.textStatus, this.tableMatchJobModels,
      this.servicecustomerModels,this.jobStatusModelModels,
      this.GiveFix2Models,this.UserModel_Models){
    print("========================");
    print(textStatus);
    print(tableMatchJobModels.id_job);
    print(tableMatchJobModels.id_customer);
    print(tableMatchJobModels.id_repairer);
    print(tableMatchJobModels.orderMatch);
    print(servicecustomerModels);
    print(GiveFix2Models);
    print(UserModel_Models);
    print("========================");
  }

  //final tableMatchJob serviceCustomerModel;
  //const ShowDetailMyJob({Key? key, required this.serviceCustomerModel})
  //    : super(key: key);

  @override
  _ShowDetailServiceState createState() => _ShowDetailServiceState(tableMatchJobModels.id_job,
      tableMatchJobModels.id_customer,textStatus,
      servicecustomerModels,jobStatusModelModels,GiveFix2Models,UserModel_Models);
}

class _ShowDetailServiceState extends State<ShowDetailMyJob> {

  String id_job = "";
  String id_customer = "";
  //List<String> detailServiceTechnician = [];
  String addressCustomerText = "";
  String identifySymptomsCustomerText = "";
  String imageFixText = "";
  String imageFix0Text = "";
  String imageFix1Text = "";
  String imageFix2Text = "";
  String imageFix3Text = "";
  String firstnameCustomerText = "";
  String lastnameCustomerText = "";
  String phoneCustomerText = "";
  String dateMeetCustomerText = "";
  String timeMeetCustomerText = "";
  bool switchValue = true;
  String textStatus = "";

  late final List<ServiceCustomer> servicecustomerModels;
  late final List<jobStatusModel> jobStatusModelModels;
  late final List<give_fix2_Model> GiveFix2Models;
  late final List<UserModel> UserModel_Models;



  _ShowDetailServiceState(String idJob,String idCustomer,String textStatus,
      List<ServiceCustomer> servicecustomerModels,List<jobStatusModel> jobStatusModelModels,
      List<give_fix2_Model> GiveFix2Models,List<UserModel> UserModel_Models){
    this.id_job = idJob;
    this.id_customer = idCustomer;
    this.textStatus = textStatus;
    this.servicecustomerModels = servicecustomerModels;
    this.jobStatusModelModels = jobStatusModelModels;
    this.GiveFix2Models = GiveFix2Models;
    this.UserModel_Models = UserModel_Models;
    print("status $textStatus");
    print(this.id_job);
    print(this.id_customer);
    print(this.servicecustomerModels);
    print(this.jobStatusModelModels);
    print(this.GiveFix2Models);
    print(this.UserModel_Models);
  }

  image0WithIdJob(String id_job){
    String imageFix0 = "";
    for(int i = 0;i<GiveFix2Models.length;i++){
      if(GiveFix2Models[i].id_job == id_job){
        //image = GiveFix2Models[i].image;
        String imageFix = GiveFix2Models[i].image;
        imageFix = imageFix.substring(1,imageFix.length-1);
        //print(imageFix);
        var textImageArr = imageFix.split(',');
        if(textImageArr[0] != ""){
          imageFix0 = textImageArr[0];
          print(imageFix0);
        }
        /*if(textImageArr[1] != ""){
          imageFix1 = textImageArr[1];
          print(imageFix1);
        }
        if(textImageArr[2] != ""){
          imageFix2 = textImageArr[2];
          print(imageFix2);
        }
        if(textImageArr[3] != ""){
          imageFix3 = textImageArr[3];
          print(imageFix3);
        }*/
        break;
      }
    }
    return imageFix0;
  }


  image1WithIdJob(String id_job){
    String imageFix1 = "";
    for(int i = 0;i<GiveFix2Models.length;i++){
      if(GiveFix2Models[i].id_job == id_job){
        //image = GiveFix2Models[i].image;
        String imageFix = GiveFix2Models[i].image;
        imageFix = imageFix.substring(1,imageFix.length-1);
        //print(imageFix);
        var textImageArr = imageFix.split(',');
        /*if(textImageArr[0] != ""){
          imageFix1 = textImageArr[0];
          print(imageFix1);
        }*/
        if(textImageArr[1] != ""){
          imageFix1 = textImageArr[1];
          print(imageFix1);
        }
        /*if(textImageArr[2] != ""){
          imageFix2 = textImageArr[2];
          print(imageFix2);
        }
        if(textImageArr[3] != ""){
          imageFix3 = textImageArr[3];
          print(imageFix3);
        }*/
        break;
      }
    }
    return imageFix1;
  }


  image2WithIdJob(String id_job){
    String imageFix2 = "";
    for(int i = 0;i<GiveFix2Models.length;i++){
      if(GiveFix2Models[i].id_job == id_job){
        //image = GiveFix2Models[i].image;
        String imageFix = GiveFix2Models[i].image;
        imageFix = imageFix.substring(1,imageFix.length-1);
        //print(imageFix);
        var textImageArr = imageFix.split(',');
        /*if(textImageArr[0] != ""){
          imageFix1 = textImageArr[0];
          print(imageFix1);
        }*/
        if(textImageArr[2] != ""){
          imageFix2 = textImageArr[2];
          print(imageFix2);
        }
        /*if(textImageArr[2] != ""){
          imageFix2 = textImageArr[2];
          print(imageFix2);
        }
        if(textImageArr[3] != ""){
          imageFix3 = textImageArr[3];
          print(imageFix3);
        }*/
        break;
      }
    }
    return imageFix2;
  }

  image3WithIdJob(String id_job){
    String imageFix3 = "";
    for(int i = 0;i<GiveFix2Models.length;i++){
      if(GiveFix2Models[i].id_job == id_job){
        //image = GiveFix2Models[i].image;
        String imageFix = GiveFix2Models[i].image;
        imageFix = imageFix.substring(1,imageFix.length-1);
        //print(imageFix);
        var textImageArr = imageFix.split(',');
        /*if(textImageArr[0] != ""){
          imageFix1 = textImageArr[0];
          print(imageFix1);
        }*/
        if(textImageArr[3] != ""){
          imageFix3 = textImageArr[3];
          print(imageFix3);
        }
        /*if(textImageArr[2] != ""){
          imageFix2 = textImageArr[2];
          print(imageFix2);
        }
        if(textImageArr[3] != ""){
          imageFix3 = textImageArr[3];
          print(imageFix3);
        }*/
        break;
      }
    }
    return imageFix3;
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
  
  phoneWithIdCustomer(String idCustomer){
    String phone = "nonFirstName";
    for(int i = 0;i<UserModel_Models.length;i++){
      if(UserModel_Models[i].id == idCustomer){
        phone = UserModel_Models[i].phone;
        break;
      }
    }
    return phone;
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


  addressWithidJob(String id_job){
    String address = "nonAddress";
    for(int i = 0;i<GiveFix2Models.length;i++){
      if(GiveFix2Models[i].id_job == id_job){
        address = GiveFix2Models[i].address1;
        break;
      }
    }
    return address;
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

/*
  Future<void>writeJsonDetailServiceTechnicianAll() async{
    backend obj = new backend();
    String addressCustomer = "";
    String identifySymptomsCustomer = "";
    String imageFix = "";
    String imageFix0 = "";
    String imageFix1 = "";
    String imageFix2 = "";
    String imageFix3 = "";
    String firstnameCustomer = "";
    String lastnameCustomer = "";
    String phoneCustomer = "";
    String dateMeetCustomer = "";
    String timeMeetCustomer = "";

    addressCustomer = await obj.showAddressGiveFixIdJob(id_job);
    identifySymptomsCustomer = await obj.showIdentifySymptomsIdJob(id_job);
    imageFix = await obj.showImageItemFixWithIdJob(id_job);
    firstnameCustomer = await obj.showFirstName(id_customer);
    lastnameCustomer = await obj.showLastName(id_customer);
    phoneCustomer = await obj.showPhone(id_customer);
    dateMeetCustomer = await obj.showDateMeetWithIdJob(id_job);
    timeMeetCustomer = await obj.showTimeMeetWithIdJob(id_job);

    print(";;;;;;;;;;;;;;;;;;");
    print(image0WithIdJob(id_job));
    print(":::::::::::::::::");
    print(addressCustomer);
    print(identifySymptomsCustomer);
    print(imageFix);
    print(firstnameCustomer);
    print(lastnameCustomer);
    print(phoneCustomer);
    print(dateMeetCustomer);
    print(timeMeetCustomer);
    print(":::::::::::::::::");
    imageFix = imageFix.substring(1,imageFix.length-1);
    print(imageFix);
    var textImageArr = imageFix.split(',');
    if(textImageArr[0] != ""){
      imageFix0 = textImageArr[0];
      print(imageFix0);
    }
    if(textImageArr[1] != ""){
      imageFix1 = textImageArr[1];
      print(imageFix1);
    }
    if(textImageArr[2] != ""){
      imageFix2 = textImageArr[2];
      print(imageFix2);
    }
    if(textImageArr[3] != ""){
      imageFix3 = textImageArr[3];
      print(imageFix3);
    }

    String textForm = '{"addressCustomer":"$addressCustomer", "identifySymptomsCustomer":"$identifySymptomsCustomer","imageFix0":"$imageFix0",'
        '"imageFix1":"$imageFix1","imageFix2":"$imageFix2","imageFix3":"$imageFix3",'
        '"firstnameCustomer":"$firstnameCustomer","lastnameCustomer":"$lastnameCustomer","phoneCustomer":"$phoneCustomer"'
        ',"dateMeetCustomer":"$dateMeetCustomer","timeMeetCustomer":"$timeMeetCustomer"}';
    print("textForm:: $textForm");
    writeJsonDetailServiceTechnician(textForm);
    //print(textImageArr[0]);
    //print(textImageArr[1]);
    //print(textImageArr[2]);
    //print(textImageArr[3]);
    print("++++++++++++++++++");
  }*/

  /*
  Future<void>writeJsonDetailServiceTechnician(String textFile) async{
    print("writeJsonDetailServiceTechnician:: $textFile");
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonDetailServiceTechnician.json');
    await file.writeAsString(textFile);
  }

  readJsonDetailServiceTechnician() async {
    String text = "";
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonDetailServiceTechnician.json');
    text = await file.readAsString();
    print("textTest:: $text");
    Map<String, dynamic> textKey = jsonDecode(text);    //print(text);

    setState(() {
      //  for(int i = 0;i< textKey.length;i++){
      //    detailServiceTechnician.add(textKey["$i"]);
      //  }

      addressCustomerText = textKey["addressCustomer"];
      identifySymptomsCustomerText = textKey["identifySymptomsCustomer"];
      imageFix0Text = textKey["imageFix0"];
      imageFix1Text = textKey["imageFix1"];
      imageFix2Text = textKey["imageFix2"];
      imageFix3Text = textKey["imageFix3"];
      firstnameCustomerText = textKey["firstnameCustomer"];
      lastnameCustomerText = textKey["lastnameCustomer"];
      phoneCustomerText = textKey["phoneCustomer"];
      dateMeetCustomerText = textKey["dateMeetCustomer"];
      timeMeetCustomerText = textKey["timeMeetCustomer"];

    });
    print("addressCustomerText:: $addressCustomerText");
    print("identifySymptomsCustomerText:: $identifySymptomsCustomerText");
    print("imageFix0Text:: $imageFix0Text");
    print("imageFix1Text:: $imageFix1Text");
    print("imageFix2Text:: $imageFix2Text");
    print("imageFix3Text:: $imageFix3Text");
    print("firstnameCustomerText:: $firstnameCustomerText");
    print("lastnameCustomerText:: $lastnameCustomerText");
    print("phoneCustomerText:: $phoneCustomerText");
    print("dateMeetCustomerText:: $dateMeetCustomerText");
    print("timeMeetCustomerText:: $timeMeetCustomerText");


    //print("readJsonDetailServiceTechnicianAll:: $detailServiceTechnician");
  }
*/

  @override
  Widget build(BuildContext context) {

    print("id_job:: $id_job");
    print("id_customer:: $id_customer");

    // if() {
    //writeJsonDetailServiceTechnicianAll();
    //readJsonDetailServiceTechnician();
    // ค่าlat
    latWithIdJob(String id_job){
      String lat = "nonValuelat";
      for(int i = 0;i<GiveFix2Models.length;i++){
        if(GiveFix2Models[i].id_job == id_job){
          lat = GiveFix2Models[i].lat;
          break;
        }
      }
      return lat;
    }
    // ค่าlng
    lngWithIdJob(String id_job){
      String lng = "nonValuelng";
      for(int i = 0;i<GiveFix2Models.length;i++){
        if(GiveFix2Models[i].id_job == id_job){
          lng = GiveFix2Models[i].lng;
          break;
        }
      }
      return lng;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange.shade100,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.yellow.shade900, Colors.yellowAccent.shade700],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          title: Text('รายละเอียดการซ่อม'),
        ),
        backgroundColor: Colors.orange.shade100,
        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) => Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //แสดงที่อยู่
                  buildshowaddress(constraints),

                  //show map ลูกค้า

                  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            width: constraints.maxWidth * 0.9,
            height: constraints.maxWidth * 0.6,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  double.parse(latWithIdJob(id_job)),
                  double.parse(lngWithIdJob(id_job)),
                ),
                zoom: 16,
              ),
              markers: <Marker>[
                Marker(
                    markerId: MarkerId('id'),
                    position: LatLng(
                      double.parse(latWithIdJob(id_job)),
                      double.parse(lngWithIdJob(id_job)),
                    ),
                    infoWindow: InfoWindow(
                        title: 'customer address',
                        snippet:
                        'lat = ${latWithIdJob(id_job)}, lng = ${lngWithIdJob(id_job)}')),
              ].toSet(),
            ),
          ),
          ],
        ),
                  buildshowDetail(constraints),
                  buildshowImageFix(constraints),
                  buildshowName(constraints),
                  buildshowPhone(constraints),
                  buildshowDate(constraints),
                  textStatus != "finish_job" && textStatus != "cancel" ?
                  buildAcceptButton(constraints) :Container(),
                  //,
                  textStatus != "finish_job" && textStatus != "cancel" ?
                  buildCancelButton(constraints) :Container()
                  //,
                ],
              ),
            ),
          ),
        ));
  }

  Row buildshowaddress(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'สถานที่นัดให้รับบริการ',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                addressWithidJob(id_job),
                style: MyConstant().h4Style(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row buildshowImageFix(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'รูปภาพประกอบ',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              // Text(
              //   'ใส่ค่าimageตรงนี้',
              //   style: MyConstant().h4Style(),
              // ),

              image0WithIdJob(id_job) != "" ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    width: 100,
                    child: CachedNetworkImage(
                      imageUrl: '${MyConstant.domain}${image0WithIdJob(id_job)}',
                      placeholder: (context, url) => ShowProgress(),
                    ),
                  ),
                ],// rep
              ):

              image1WithIdJob(id_job) != "" ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    width: 100,
                    child: CachedNetworkImage(
                      imageUrl: '${MyConstant.domain}${image1WithIdJob(id_job)}',
                      placeholder: (context, url) => ShowProgress(),
                    ),
                  ),
                ],// rep
              ):

              image2WithIdJob(id_job) != "" ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    width: 100,
                    child: CachedNetworkImage(
                      imageUrl: '${MyConstant.domain}${image2WithIdJob(id_job)}',
                      placeholder: (context, url) => ShowProgress(),
                    ),
                  ),
                ],// rep
              ):

              image3WithIdJob(id_job) != null ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    width: 100,
                    child: CachedNetworkImage(
                      imageUrl: '${MyConstant.domain}${image3WithIdJob(id_job)}',
                      placeholder: (context, url) => ShowProgress(),
                    ),
                  ),
                ],// rep
              ):Row()

            ],
          ),
        ),
      ],
    );
  }

  Row buildshowDetail(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'แจ้งอากร',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                identifySymptomsWithIdJob(id_job),
                style: MyConstant().h4Style(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row buildshowName(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'ชื่อผู้รับบริการ',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                firstnameWithIdCustomer(id_customer) + ' ' + lastnameWithIdCustomer(id_customer),
                style: MyConstant().h4Style(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row buildshowPhone(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'เบอร์โทรลูกค้า',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                phoneWithIdCustomer(id_customer),
                style: MyConstant().h4Style(),
              ),

        Padding(
          padding: const EdgeInsets.fromLTRB(280, 0, 0, 0),
          child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green.shade600,
            onPrimary: Colors.white,
          ),
          child: Text('call'),
          onPressed: ()async{
            launch('tel:// ${phoneWithIdCustomer(id_customer)}');
          },
          ),
        ),
      ],
          ),
        ),
      ],
    );
  }

  Row buildshowDate(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'วันเวลาที่นัดรับบริการ',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                dateMeetWithIdJob(id_job) + ' | ' + timeMeetWithIdJob(id_job),
                style: MyConstant().h4Style(),
              )
            ],
          ),
        ),
      ],
    );
  }

  //เปลี่ยนสถานะเป็นตอบรับ
  Container buildAcceptButton(BoxConstraints constraints) {
    return Container(
      alignment: FractionalOffset.bottomCenter,
      width: constraints.maxHeight * 0.75,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
            textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        onPressed: () {
          print('##  ==> click accept job');
          backend obj = new backend();
          obj.updateStatusBackend("finish_job", id_job);
          Navigator.pop(context);
        },
        child: Text('งานเสร็จสิ้น'),
      ),
    );
  }


  //เปลี่ยนสถานะเป็นยกเลิก
  Container buildCancelButton(BoxConstraints constraints) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: constraints.maxHeight * 0.75,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
            textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        onPressed: () {
          //if(switchValue == true) {
            print('##  ==> click cancel');
            backend obj = new backend();
            //obj.updateStatusBackend("cancel", id_job);
            obj.updateDetailMyjob(id_job);
            print("onPressed:: $id_job");
            //switchValue == false;
            //print("swichValueDetailMyJob $switchValue");
          //}
            Navigator.pop(context);
        },
        child: Text('ยกเลิกงาน'),
      ),
    );
  }
}
