import 'package:app_repair/backend/backend.dart';
import 'package:app_repair/models/jobStatusModel.dart';
import 'package:app_repair/models/send_table_match_job.dart';
import 'package:app_repair/models/service_customer.dart';
import 'package:app_repair/models/table_find_repaierer_Model.dart';
import 'package:app_repair/models/user_model.dart';
import 'package:app_repair/states/submit_service_customer.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_image.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
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


class ShowDetailServiceCustomer extends StatefulWidget {
  final ServiceCustomer serviceCustomerModel;
  final jobStatusModel jobStatusModelModels;
  final tableMatchJob tableMatchJobModels;
  final UserModel serivceRepaierModels;
  final tableFindRepaierer tableFindRepaiererModels;

  ShowDetailServiceCustomer(this.serviceCustomerModel,
      this.jobStatusModelModels,this.tableMatchJobModels
      ,this.serivceRepaierModels,this.tableFindRepaiererModels){
    print(serviceCustomerModel);
    print(jobStatusModelModels);
  }


  @override
  _ShowDetailServiceState createState() => _ShowDetailServiceState(serviceCustomerModel,jobStatusModelModels,tableMatchJobModels,serivceRepaierModels,tableFindRepaiererModels);
}

class _ShowDetailServiceState extends State<ShowDetailServiceCustomer> {
  ServiceCustomer? serviceCustomerModel;
  final jobStatusModel jobStatusModelModels;
  final tableMatchJob tableMatchJobModels;
  final UserModel serivceRepaierModels;
  final tableFindRepaierer tableFindRepaiererModels;


  TextEditingController dateController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateMeetController = TextEditingController();
  TextEditingController idJobController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController timeMeetController = TextEditingController();

  String nameWithBoom ="";
  List _items = [];

  String keyFirstname = "";
  String keyPhone = "";
  String dateMeet = "";
  String firstnameRepairer = "";
  String phoneRepairer = "";
  String statusRepairer = "";
  List<UserModel> UserModel_Models = [];
  List<UserModel> RepairerModel_Models = [];
  //List<tableMatchJob> tableMatchJobModels = [];


  String idCustomer = "";


  late final UserModel userModel;

  _ShowDetailServiceState(this.serviceCustomerModel,this.jobStatusModelModels,this.tableMatchJobModels,this.serivceRepaierModels,this.tableFindRepaiererModels ){
    print(serviceCustomerModel);
  }
  /*
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');

    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }*/

  /*
  Future<void> readJsonPath() async {
    String text = "";
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonPath.json');
    text = await file.readAsString();
    Map<String, dynamic> textKey = jsonDecode(text);    //print(text);
    print(textKey["firstname"]);
    setState(() {
      keyFirstname = textKey["firstname"];
      keyPhone = textKey["phone"];
      firstnameRepairer = textKey["firstnameRepairer"];
      phoneRepairer = textKey["phoneRepairer"];
      statusRepairer = textKey["statusRepairer"];
    });
  }*/

  /*
  Future<void> writeJson(String textFile) async{
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jsonPath.json');
    await file.writeAsString(textFile);
    //final _myFile = File('assets/sample.json');
    //await _myFile.writeAsString(textFile);
  }

   */

  /*
  writeJson1(String num) async{
    print("writeJson1");
    backend obj = new backend();
    String textKey = 'nonValue';
    textKey = await obj.showFirstName(num);
    String textPhone = await obj.showPhone(num);
    //String textIdRepairer = await obj.

    String textIdJob = idJobController.text;
    String textIdRepairer = await obj.showIdRepairerFromJob(textIdJob);
    String textFirstName = await obj.showFirstName(textIdRepairer);
    String textPhoneRepairer = await obj.showPhone(textIdRepairer);
    String textstatusRepairer = await obj.showStatusRepairerFind(textIdRepairer);

    print("ansIdJob:: $textIdJob");
    print("ansIdRepairer:: $textIdRepairer");
    print("ansFirstName:: $textFirstName");
    print("ansPhoneRepairer:: $textPhoneRepairer");
    print("ansStatusRepairer:: $textstatusRepairer");

    String textForm = '{"firstname":"$textKey", "phone":"$textPhone","idJob":"$textIdJob",'
        '"idRepairer":"$textIdRepairer","firstnameRepairer":"$textFirstName","phoneRepairer":"$textPhoneRepairer",'
        '"statusRepairer":"$textstatusRepairer"}';
    print("textForm:: $textForm");
    writeJson(textForm);
  }*/

  Future<Null> readDetailBooking() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    idCustomer = id!;
    readUserModel(id);
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
          print('id4:: ${model.id}');
          print('firstname4:: ${model.firstname}');
          print('lastname4:: ${model.lastname}');
          print('type4:: ${model.type}');
          print('address4:: ${model.address}');
          print('phone4:: ${model.phone}');
          print('user4:: ${model.user}');
          print('password4:: ${model.password}');
          print('avatar4:: ${model.avatar}');
          print('lat4:: ${model.lat}');
          print('lng4:: ${model.lng}');
          print('type_technician4:: ${model.type_technician}');
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

  /*Future<void> getFirstName() async {
    backend obj = new backend();
    String text = await obj.showFirstName('1');
    print('text:: $text');
    setState(() {
      nameWithBoom = text;
    });
    print("nameWithBoom:: $nameAddBoom");
  }*/

  List<String> pathImages = [];

  @override
  void initState() {
    readDetailBooking();
    //getFirstName();
    // TODO: implement initState
    //String text = nameWithBoom;
    //print("======");
    //print(nameWithBoom);
    //print("=========");
    serviceCustomerModel = widget.serviceCustomerModel;
    dateController.text = serviceCustomerModel!.date1;
    detailController.text = serviceCustomerModel!.identifySymptoms;
    addressController.text = serviceCustomerModel!.address1;
    dateMeetController.text = serviceCustomerModel!.dateMeet;
    idJobController.text = serviceCustomerModel!.id_job;
    imageController.text = serviceCustomerModel!.image;
    timeMeetController.text = serviceCustomerModel!.timeMeet;

    //nameAddBoom.text = nameWithBoom;
    //print("+++++++++++++++++");
    //print(nameAddBoom.text.toString());
  }

  /* _getImagesPath() async {
    backend obj = new backend();
    return await obj.showFirstName('1');
  }*/

  firstnameWithId(String id){
    print(id);
  }


  @override
  Widget build(BuildContext context) {
    //writeJson1('1');
    //readJson();
    //readJsonPath();

    String textOrderJob101 = idJobController.text.toString();
    String imageJob = "";
    String textImage = imageController.text.toString();
    /*String imagesPath = "";
    _getImagesPath().then((path) {
      imagesPath = path;
      print("get::$imagesPath"); //prints correct path
    });
    print("get::$imagesPath"); //prints correct path*/
    textImage = textImage.substring(1,textImage.length-1);
    print("Image:: $textImage");
    print(textImage[0]);
    print(textImage[textImage.length - 1]);
    var textImageArr = textImage.split(',');
    print(textImageArr[0]);


    for(int i = 0;i<textImageArr.length;i++){
      if(textImageArr[i] != "" && imageJob == ""){
        imageJob = textImageArr[i];
      }
    }

    /*
    if(textImageArr[0] != ""){
      imageJob = textImageArr[0];
    }*/


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

     /* body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            /*ElevatedButton(
              child: const Text('Load Data'),
              onPressed: readJson,
            ),*/

            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             'ผู้ใช้ ',
                             style: MyConstant().h3GrayStyle(),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text(
                             'วันที่นัดใช้บริการ ',
                             style: MyConstant().h3GrayStyle(),
                           ),
                         ],
                       ),
                       Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children:[
                          Text(
                           dateMeetController.text,
                           // dateController.text,
                         //dateController.text,
                            style: MyConstant().h4Style(),
                          ),
                        ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text(
                             'เวลานัดใช้บริการ ',
                             style: MyConstant().h3GrayStyle(),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:[
                           Text(
                             timeMeetController.text,
                             style: MyConstant().h4Style(),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text(
                             'รายละเอียดสิ่งที่ต้องการซ่อม ',
                             style: MyConstant().h3GrayStyle(),
                           ),
                         ],
                       ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                           Text(
                             detailController.text,
                             style: MyConstant().h4Style(),
                           ),
                        ],
                      ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text(
                             'ผู้รับบริการ ',
                             style: MyConstant().h3GrayStyle(),
                           ),
                           /*Text(
                             ,
                             style: MyConstant().h3GrayStyle(),
                           ),*/
                         ],

                       ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                       Text(
                         keyFirstname,
                         style: MyConstant().h4Style(),
                       ),
                      ],
                    ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text(
                             'ที่อยู่ ',
                             style: MyConstant().h3GrayStyle(),
                           ),
                         ],
                       ),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(
                             margin: EdgeInsets.symmetric(vertical: 16),
                             width: 250,
                             height: 250,
                             child: GoogleMap(
                               initialCameraPosition: CameraPosition(
                                 target: LatLng(
                                   double.parse(serviceCustomerModel!.lat),
                                   double.parse(serviceCustomerModel!.lng),
                                 ),
                                 zoom: 16,
                               ),
                               markers: <Marker>[
                                 Marker(
                                     markerId: MarkerId('id'),
                                     position: LatLng(
                                       double.parse(serviceCustomerModel!.lat),
                                       double.parse(serviceCustomerModel!.lng),
                                     ),
                                     infoWindow: InfoWindow(
                                         title: 'You Here ',
                                         snippet:
                                         'lat = ${serviceCustomerModel!.lat}, lng = ${serviceCustomerModel!.lng}')),
                               ].toSet(),
                             ),
                           ),
                         ],
                       ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                         Text(
                           addressController.text,
                           style: MyConstant().h4Style(),
                         ),
                      ],
                    ),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text(
                             'เบอร์โทรศัพท์ ',
                             style: MyConstant().h3GrayStyle(),
                           ),
                         ],
                       ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                             Text(
                               keyPhone,
                               style: MyConstant().h4Style(),
                             )
                          ],
                        ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             'ช่าง ',
                             style: MyConstant().h3GrayStyle(),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text(
                             'ชื่อช่าง ',
                             style: MyConstant().h3GrayStyle(),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:[
                           Text(
                             firstnameRepairer,
                             style: MyConstant().h4Style(),
                           )
                         ],
                       ),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text(
                             'เบอร์ช่าง ',
                             style: MyConstant().h3GrayStyle(),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:[
                           Text(
                             phoneRepairer,
                             style: MyConstant().h4Style(),
                           )
                         ],
                       ),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text(
                             'สถานะช่าง ',
                             style: MyConstant().h3GrayStyle(),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:[
                           Text(
                             statusRepairer,
                             style: MyConstant().h4Style(),
                           )
                         ],
                       ),

                       //Container(width: 1000, child: ShowImage(path: imageJob)),
                       /*
                       Image.file(
                         File(MyConstant.logo),
                         width: 100,
                         height: 100,
                         repeat: ImageRepeat.repeat,
                       ),
                        */

                       imageJob != ""
                           ?  Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(
                             margin: EdgeInsets.symmetric(vertical: 16),
                             width: 100,
                             child: CachedNetworkImage(
                               imageUrl: '${MyConstant.domain}${"$imageJob"}',
                               placeholder: (context, url) => ShowProgress(),
                             ),
                           ),
                         ],// repairer_app/avatar/avatar24729.jpg
                       ): Container(),

                       Align(
                         alignment: Alignment.center,
                         child:                       ElevatedButton(
                           style: MyConstant().myButtonStyle(),
                           onPressed: () {
                             print('##  ==> click cancel');
                             backend obj = new backend();
                             obj.updateStatusBackend("cancel",textOrderJob101);
                           },
                           child: Text('ยกเลิก'),
                         ),
                       ),



                     ],
                   ),
                   /* child: ListTile(
                      leading: Text(_items[index]["id"]),
                      title: Text(_items[index]["name"]),
                      subtitle: Text(_items[index]["description"]),
                    ),*/
                  );
                },
              ),
            )
                : Container()
          ],
        ),
      ),*/

        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) => Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  buildCustomer(constraints),
                  buildshowName(constraints),
                  buildshowPhone(constraints),
                  buildshowDate(constraints),
                  buildshowDetail(constraints),
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
                               double.parse(serviceCustomerModel!.lat),
                               double.parse(serviceCustomerModel!.lng),
                             ),
                             zoom: 16,
                           ),
                           markers: <Marker>[
                             Marker(
                                 markerId: MarkerId('id'),
                                position: LatLng(
                                   double.parse(serviceCustomerModel!.lat),
                                   double.parse(serviceCustomerModel!.lng),
                                  ),
                                 infoWindow: InfoWindow(
                                     title: 'You Here ',
                                     snippet:
                                         'lat = ${serviceCustomerModel!.lat}, lng = ${serviceCustomerModel!.lng}')),
                           ].toSet(),
                         ),
                       ),
                     ],
                   ),
                  buildTech(constraints),
                  buildshowNameTech(constraints),
                  buildshowPhoneTech(constraints),
                  buildshowStatus(constraints),


                  Align(
                    alignment: Alignment.center,
                    child:                       ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal:50, vertical: 0),
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        print('##  ==> click cancel');
                        backend obj = new backend();
                        obj.updateStatusBackend("cancel",textOrderJob101);
                        Navigator.pop(context);
                      },
                      child: Text('ยกเลิก'),
                    ),
                  ),
                ],

              ),

            ),
          ),
        )
    );
  }




  Row buildCustomer(BoxConstraints constraints) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ผู้ใช้บริการ',
                    style: MyConstant().h2BlackStyle(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row buildTech(BoxConstraints constraints) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ผู้ให้บริการ',
                    style: MyConstant().h2BlackStyle(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
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
                addressController.text,
                style: MyConstant().h4Style(),
              )
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
                    'รายละเอียดสิ่งที่ต้องการซ่อม',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                detailController.text,
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
                firstnameWithIdCustomer(idCustomer)+" "+lastnameWithIdCustomer(idCustomer),
                style: MyConstant().h4Style(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row buildshowNameTech(BoxConstraints constraints) {
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
                    'ชื่อผู้ให้บริการ',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                serivceRepaierModels.firstname+" "+serivceRepaierModels.lastname,
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
                    'เบอร์โทรศัพท์',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                  //serivceRepaierModels.phone,
                phoneWithIdCustomer(idCustomer),
                style: MyConstant().h4Style(),
              )
            ],
          ),
        ),
      ],
    );
  }
  Row buildshowPhoneTech(BoxConstraints constraints) {
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
                    'เบอร์โทรศัพท์ของผู้ให้บริการ',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                serivceRepaierModels.phone,
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
                    launch('tel:// ${serivceRepaierModels.phone}');
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
                dateMeetController.text+' | '+timeMeetController.text,
                style: MyConstant().h4Style(),
              )
            ],
          ),
        ),
      ],
    );
  }

   buildshowStatus(BoxConstraints constraints) {
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
                    'สถานะของช่าง',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                tableFindRepaiererModels.status_repairer,
                style: MyConstant().h4Style(),
              )
            ],
          ),
        ),
      ],
    );
  }

}
