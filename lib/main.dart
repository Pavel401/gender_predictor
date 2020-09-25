import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
         theme: ThemeData.dark(), 
         debugShowCheckedModeBanner: false,

         home: HomePage(),
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  

  TextEditingController _nameController= TextEditingController(); 
  var results; 
  


  predictGender(String name)async{
    var url ="https://api.genderize.io/?name=$name";
    var res= await  http.get(url);
    var body= jsonDecode(res.body);
   
    results = "Gender: ${body['gender']}, Probability: ${body['probability']}";
    setState(() {});
  

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("GENDER PREDICTOR BETA "), 
       centerTitle: true,
       
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
          children: [
            
          new Text("ENTER YOUR NAME "),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: new TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Input Your Name',
              
             

              ) ,

            ),
          ),
          new RaisedButton(
          onPressed:() => predictGender(_nameController.text), 
          child: Text("Calculate"),
          
          ),
          if(results !=  null)new Text(results),
          

          ],

         
        ),
      ),
    );
  }
}