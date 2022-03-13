import 'package:app_repair/models/review_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
import 'package:app_repair/bodys/reviewDetail.dart';

class ShowReview extends StatefulWidget {

  const ShowReview({ Key? key }) : super(key: key);

  @override
  _ShowReviewState createState() => _ShowReviewState();
}

class _ShowReviewState extends State<ShowReview> {



  bool load = true;
  bool? haveData;
  List<ServiceCustomer> servicecustomerModels = [];
  List _items = [];
  String keyValueSend = "";
  List<String> keyText = [];
  List<jobStatusModel> jobStatusModelModels = [];
  List<tableMatchJob> tableMatchJobModels = [];
  List<UserModel> serivceRepaierModels = [];
  List<tableFindRepaierer> tableFindRepaiererModels = [];

  //add review
  List<ReviewModel> reviewModel = [];



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
            readReview(model.id_job);
          });
        }
      }
    });
  }

  readReview(String id_job) async{
    print("readReview_fuc");
    if(reviewModel.length != 0){
      reviewModel.clear();
    }else{

    }

    String showNewJob = '${MyConstant.domain}/repairer_app/reviewPersonWhereId.php?isAdd=true&id_job=$id_job';
    await Dio().get(showNewJob).then((value) {
      print('==>$value');
      if (value.toString() == 'null') {
        print("readTableReviewNULL");
        setState(() {

        });
      } else {
        print("haveDataTableReview");
        // Have Data
        for (var item in json.decode(value.data)) {
          int count = 0;
          ReviewModel model = ReviewModel.fromMap(item);
          //print('detail ==>> ${model.identifySymptoms}');
          print('id_repairer909:: ${model.id_repairer}');
          print('id_customer909:: ${model.id_customer}');
          print('score_star909:: ${model.score_star}');
          print('text_recommend909:: ${model.text_recommend}');
          print('order_person909:: ${model.order_person}');
          print('id_job101:: ${model.id_job}');
          print('status_review:: ${model.status_review}');



          setState(() {

            reviewModel.add(model);
          });
          // count++;
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
            jobStatusModelModels.add(model);
          });
        }

      }
    });
  }
  idRepairerWithIdJob(String id_job){
    String id_repairer = "nonid_repairer";
    for(int i = 0;i<tableMatchJobModels.length;i++){
      if(tableMatchJobModels[i].id_job == id_job){
        id_repairer = tableMatchJobModels[i].id_repairer;
        break;
      }
    }
    return id_repairer;
  }

  readTableMatch(String id_job) async {
    print("readTableMatch101");
    if (tableMatchJobModels.length != 0) {
      tableMatchJobModels.clear();
    } else {

    }




    String showNewJob = '${MyConstant.domain}/repairer_app/getTableMatchJobWhereIdJob.php?isAdd=true&id_job=$id_job';
    await Dio().get(showNewJob).then((value) {
      print('==>$value');
      if (value.toString() == 'null') {
        print("readTableMatchNULL");
        setState(() {

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



    String showNewJob = '${MyConstant.domain}/repairer_app/getTableFindRepaiererWhereIdRepairer.php?isAdd=true&id=$idRepairer';
    await Dio().get(showNewJob).then((value) {
      print('==>$value');
      if (value.toString() == 'null') {
        print("readTableMatchNULL");
        setState(() {

        });
      } else {
        // Have Data
        for (var item in json.decode(value.data)) {
          tableFindRepaierer model = tableFindRepaierer.fromMap(item);
          print('type_repairer50:: ${model.type_repairer}');
          print('lat50:: ${model.lat}');
          print('lng50:: ${model.lng}');
          print('status_repairer50:: ${model.status_repairer}');
          print('price50:: ${model.price}');
          print('id_repairer50:: ${model.id_repairer}');




          setState(() {
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

  checkIdJobInReview(String id_job){
    String reviewAns = "nonReview";
    for(int i = 0;i<reviewModel.length;i++){
      if(reviewModel[i].id_job == id_job){
        reviewAns = reviewModel[i].id_job;
        break;
      }
    }
    return reviewAns;
  }

  checkIdJobInReviewBool(String id_job){
    if(checkIdJobInReview(id_job) == "nonReview"){
      print("nonReviewTrue");
      return true;
    }else{
      print("nonReviewFalse");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    //checkIdJobInReview("404");
    
    if(_items.isEmpty) {
    }else{
      print("++1+");
      print(_items[0]);
    }

    return Scaffold(

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


  RefreshIndicator buildListView(BoxConstraints constraints) {

    return RefreshIndicator(
      onRefresh:readMybooking,
      child: ListView.builder(
        itemCount: servicecustomerModels.length,
        itemBuilder: (context, index) => Card(
          child:tableMatchJobModels.isNotEmpty && jobStatusModelModels.isNotEmpty
              && statusWithIdJob(servicecustomerModels[index].id_job) == "finish_job"
              && checkIdJobInReview(servicecustomerModels[index].id_job) == "nonReview"
               ?
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
                                    ShowReviewDetail(context,servicecustomerModels[index].id,idRepairerWithIdJob(servicecustomerModels[index].id_job),servicecustomerModels[index].id_job),
                                    /*
                                        ShowDetailServiceCustomer(
                                          servicecustomerModels[index],
                                          jobStatusModelModels[index],
                                          tableMatchJobModels[index],
                                          serivceRepaierModels[index],
                                          tableFindRepaiererModels[index],
                                        ),
                                    */
                                  ));
                            },
                            icon:
                            Icon(Icons.announcement, size: 15),
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
                            statusWithIdJob(servicecustomerModels[index].id_job),
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

