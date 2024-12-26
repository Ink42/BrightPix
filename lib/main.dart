

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';

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

class _landingSectionState extends State<landingSection> with WidgetsBindingObserver {
  List<CameraDescription> cameras = [];
  CameraController? controller;


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (controller == null|| controller?.value.isInitialized == false ){
      return;
    }
    if (state == AppLifecycleState.inactive){
      controller?.dispose();
    }
    else if (state == AppLifecycleState.resumed){
      _setupCameraController();
    }
  }
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
          CameraPreview(controller!),
        IconButton(onPressed: ()async{
          XFile pic = await controller!.takePicture();
          Gal.putImage(pic.path);
        }
        , icon: Icon(Icons.camera,size: 100,))
      ],),
    )
    );
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
          if (!mounted){return;
          }
          setState(() {
            
          });
        }).catchError((Object e){
          print(e);
        });
    }
  }
}