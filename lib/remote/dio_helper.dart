import 'package:dio/dio.dart';

class DioHelper {
 static Dio dio = Dio();


 static init(){
   dio = Dio(
     BaseOptions(
       baseUrl: "https://student.valuxapps.com/api/",
       receiveDataWhenStatusError: true,
     )
   );
 }

 static Future<Response> getData({
    required String path ,
    Map<String,dynamic>? query,
   String lang="en" ,
   String? token
 }

 )async{

   dio.options.headers = {
     "Content-Type":"application/json",
     "Authorization":token,
     "lang":lang

   };
 return await dio.get(path,queryParameters:query ,);
}

static Future<Response> postData ({
  required String path ,
   Map<String,dynamic>? query,
  String lang="ar" ,
  String? auth,
  required Map<String,dynamic> data
})async{
   dio.options.headers = {
     "Content-Type":"application/json",
     "Authorization":auth,
  "lang":lang

  };

   return await dio.post(path,queryParameters: query,data: data);
}


 static Future<Response> putData ({
   required String path ,
   Map<String,dynamic>? query,
   String lang="ar" ,
   String? auth,
   required Map<String,dynamic> data
 })async{
   dio.options.headers = {
     "Content-Type":"application/json",
     "Authorization":auth,
     "lang":lang

   };

   return await dio.put(path,queryParameters: query,data: data);
 }
}