import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<FormState> key = GlobalKey<FormState>();


  void OpenDiaLog(){
    showDialog(context: context, builder: (context){
      bool? check = false;
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
        title: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                 return value!.isNotEmpty ? null : "Invalid Field";
                },
                decoration: InputDecoration(
                  hintText: "Enter Some Text"
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Choose"),
                  Checkbox(value: check, onChanged: (value) {
                    setState(() {
                      check = value;
                    });
                  },)
                ],
              )
            ],
          )
        ),
        actions: <Widget>[
          TextButton(onPressed: (){
            if(key.currentState!.validate()){
              Navigator.of(context).pop();
            }
          }, child: Text('Ok'))
        ],

      ) ;
      },) ;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text("Opendialog"),
            onPressed: OpenDiaLog,
          ),
        ),
      ),
    );
  }
}