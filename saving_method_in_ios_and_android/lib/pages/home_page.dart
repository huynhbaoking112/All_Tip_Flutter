import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dio dio = Dio();
  double progress = 0;
  bool isLoading = false;

  Future<bool> saveVideo(String url, String fileName) async {
    Directory? directory;

    try {
      //Nếu nền tảng là Android
      if (Platform.isAndroid) {
        //check quyền truy cập vào bộ nhớ
        if (await _checkPermission(Permission.storage)) {
          //lấy thông tin thư mục lưu trữ
          directory = await getExternalStorageDirectory();
          //--/storage/emulated/0/Android/data/com.example.saving_method_in_ios_and_android/files

          // Tạo một thư mục riêng biệt
          String newPath = '';
          List<String> paths = directory!.path.split('/');

          for (int i = 1; i < paths.length; i++) {
            if (paths[i] != 'Android') {
              newPath += "/" + paths[i];
            } else {
              break;
            }
          }
          newPath += '/myApp';
          directory = Directory(
              newPath); //--Tại đây nếu muốn tạo trên thiết bị phải dùng lệnh directory.create
        } else {
          return false;
        }
      }
      //hệ điều hành ios
      else {
        if (await _checkPermission(Permission.storage)) {
          //tạo đường dẫn đến thư mục gốc của ứng dụng
          directory = await getApplicationDocumentsDirectory();
          // directory = await getTemporaryDirectory();

          //tạo đường dẫn đến thư mục lưu trữ hình ảnh
          directory = Directory(directory.path + "/myApp");
        } else {
          return false;
        }
      }

      //Chung cho cả 2 hệ điều hành

      //Tạo thư mục lưu trữ hình ảnh nếu chưa tồn tại
      if (!await directory.exists()) {
        if (Platform.isAndroid) {
          if (await _checkPermission(Permission.manageExternalStorage)) {
            await directory.create(recursive: true);
          } else {
            return false;
          }
        } else {
          await directory.create(recursive: true);
        }
      }

      // tạo file
      File fileApp = await File(directory.path + '/' + fileName);

      // Tải ảnh về

      if (await directory.exists()) {
        dio.download(
          url,
          fileApp.path,
          onReceiveProgress: (count, total) {
            setState(() {
              progress = count / total;
            });
          },
        );

        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //Check Quyền
  Future<bool> _checkPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }

    return false;
  }


  void Download(String url, String name)async{

    setState(() {
      isLoading = true;
      progress = 0 ;
    });

    bool check = await saveVideo(url, name);

    if(check){
      print("File downloaded");
    }else{
      print("Problem downloading file");
    }
    setState(() {
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: isLoading ? Padding(padding: EdgeInsets.all(8),
          child: LinearProgressIndicator(
            minHeight: 10,
            value: progress,
          ),
          ) :ElevatedButton(
            onPressed: () {
              Download(
                  "https://i.pinimg.com/236x/9e/c8/f5/9ec8f5f091cd575d0a70fa2c32094bdd.jpg",
                  "anh.jpg");
            },
            child: Text("Download"),
          ),
        ),
      ),
    );
  }
}
