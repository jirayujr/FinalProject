import 'package:app_repair/bodys/show_mybooking_customer.dart';
import 'package:app_repair/states/edit_profile_technician.dart';
import 'package:app_repair/states/submit_service_customer.dart';
import 'package:app_repair/states/search_service.dart';
import 'package:app_repair/states/authen.dart';
import 'package:app_repair/states/create_account.dart';
import 'package:app_repair/states/customer.dart';
import 'package:app_repair/states/edit_profile_customer.dart';
import 'package:app_repair/states/technician.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_repair/backend/backend.dart';


final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/customer': (BuildContext context) => Customer(),
  '/technician': (BuildContext context) => Technician(),
  '/searchservice': (BuildContext context) => SearchService(),
  '/submitservice': (BuildContext context) => SubmitService(),
  '/editprofilecustomer': (BuildContext context) => EditProfileCustomer(),
  '/editprofiletechnician': (BuildContext context3654) => EditProfileTechnician(),
  '/showbookingcustomer': (BuildContext context) => ShowBookingCustomer(),
  
};

String? initialRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');
  preferences.clear();
  print('### type ===>> $type');
  if (type?.isEmpty ?? true) {
    initialRoute = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case 'user':
        initialRoute = MyConstant.routeCustomerService;
        runApp(MyApp());
        break;
      case 'technician':
        initialRoute = MyConstant.routeTechnicianService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //showTestFind();
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initialRoute,
    );
  }
}

Future<Null> showTestFind() async{
  backend obj = new backend();
  String ans = await obj.findRepairMatchBackend("testCancelDate","computerTechnician","20","30","1");
  print("testMatchRepairer :: $ans");
}
