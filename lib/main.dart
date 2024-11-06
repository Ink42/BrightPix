

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(

      home: landingSection(),
    )
  );
}



class landingSection extends StatefulWidget {
  landingSection({super.key});

  @override
  State<landingSection> createState() => _landingSectionState();
}

class _landingSectionState extends State<landingSection> {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setupCameraController(); 
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: _BuildUI(),
    );
  }
  Widget _BuildUI(){
    if (controller == null || controller?.value.isInitialized == false ){
      return const Center( child: CircularProgressIndicator(),);
    }
    return SafeArea(child: SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CameraPreview(controller!)

      ],),
    ));
  }
  Future<void> _setupCameraController()async{
    List<CameraDescription> _cameras = await availableCameras();
    if (_cameras.isNotEmpty){
      setState(() {
        cameras = _cameras;
      });
      controller = CameraController(
        cameras.first, 
        ResolutionPreset.high);
        controller?.initialize().then((_){
          setState(() {
            
          });
        });
    }
  }
}