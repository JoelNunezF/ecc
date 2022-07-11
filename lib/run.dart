// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_ecc/widgets/botons/BtnMode.dart';
import 'package:project_ecc/widgets/botons/BtnPump.dart';
import 'package:project_ecc/widgets/bottom_navigation.dart';
import 'package:project_ecc/widgets/charts/chart_temperature.dart';
import 'package:project_ecc/widgets/charts/chart_humidity.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';



var prueba = [];
var k = 1;
final ref = FirebaseDatabase.instance.ref();

class Run extends StatefulWidget {
  const Run({Key? key}) : super(key: key);

  @override
  State<Run> createState() => _RunState();
}

class _RunState extends State<Run> {
  StreamSubscription? _dataStream;
  String _displayData = "";
  @override
  void initState() {
    super.initState();
    _activaEco();
  }

  var documento = "";
  void _activaEco() {
    ref.onValue.listen((event) {
      final String data = event.snapshot.value.toString(); //JSON COMPLETO
      setState(() {
        _displayData = data;
        documento = _displayData.replaceAll(
            RegExp("{|}|Motor: |Humedad: |Temperatura: |Bomba: "),
            ""); //Separando el JSON (decodificando)
        documento.trim(); //Recortando espacios en blanco
      });
      if (prueba.isEmpty) {
        Future.delayed(const Duration(seconds: 5), () {
          setState(() {
            prueba.addAll(documento
                .split(',')); //Agregando los datos del Json en una lista
          });
        });
      } else {
        prueba.clear(); //Borramos los datos anteriores
        prueba.addAll(documento.split(',')); //traemos los nuevos datos
      }
    });
  } //end activaEco()

  @override   
  Widget build(BuildContext context) {
    if (prueba.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Cargando, por favor espere...",
                  style: TextStyle(fontSize: 25)),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 12,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      );
      
    }

    return Scaffold(
      
      bottomNavigationBar: const bottom_navigation(),
      body: Container(

      decoration: BoxDecoration(image: DecorationImage(image: Svg('assets/images/li.svg'),
      fit: BoxFit.cover)),
      child: ListView(
        padding: EdgeInsets.fromLTRB(2, 80, 2, 2),
        children: <Widget>[
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(
            'https://placeimg.com/640/480/any',
            fit: BoxFit.fitWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          margin: EdgeInsets.fromLTRB(100, 100, 100, 100),
        ),
          Column(
            
            children: [

              
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Flexible(
                        flex: 2,
                        child: Card(
                          elevation: 25,
                          margin: EdgeInsets.all(5.0),
                          color: Color.fromARGB(255, 255, 255, 255),
                          child: chart_humidity(),
                          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),)
                        )),
                    Flexible(
                        flex: 2,
                        child: Card(
                          margin: EdgeInsets.all(5.0),
                          color: Color.fromARGB(255, 255, 255, 255),
                          
                          
                          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),),
                          child: chart_temperature(),
                        )),
                  ],
                ),
              Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [BtnMode(), BtnPump()],
                
                
              ),
              
            ],
          ),
          

        ],
      ),
      
    ),
    );
    

    
    
  
  }

  @override
  void deactivate() {
    _dataStream!.cancel();
    super.deactivate();
  }
}

/* child: ListView(
          children: <Widget>[
            Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [progressbar_pump()],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [chart_temperature()],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [chart_humidity()],
                    ),
                  ),
                ]),
          ],
          //end ListView
        ), */
