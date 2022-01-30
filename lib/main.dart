import 'package:flutter/material.dart';
import 'package:repscheme/database_helper.dart';

void main() {
  runApp( const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final repController = TextEditingController();
  final weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Center(child: Text('Log')),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child:ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller:repController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Rep scheme',
                  labelStyle: TextStyle(
                    fontSize: 12,
                    color: Color(0xff64b5f6)
                  ),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller:weightController,
                // autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Weight(Numbers Only)',
                  labelStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xff64b5f6),
                  ),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50,50,50,0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: TextButton(
                  onPressed:()async{

                    String repScheme = repController.text;
                    int weight =int.parse(weightController.text);
                    if(weight==null || repScheme==null){
                      print('Error');
                    }else {
                      DatabaseHelper data = DatabaseHelper.instance;
                      int i = await data.insert(
                          {
                            'RepScheme': repScheme,
                            'weight': weight
                          }
                      );
                    }
                  },
                  child: const Text(
                    'Add Workout',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ],
        ) ,
      ),
    );
  }
}
