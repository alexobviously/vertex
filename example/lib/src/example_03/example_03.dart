import 'package:vector_math/vector_math.dart' as vec;
import 'package:flutter/material.dart';
import 'package:vertex/vertex.dart';

import '../blend_mask/blend_mask.dart';


class Example03 extends StatefulWidget {
  @override
  _Example03State createState() => _Example03State();
}

class _Example03State extends State<Example03> {
  CameraVertexController manController;

  @override
  void initState() {
    super.initState();
    manController = CameraVertexController(context, [
      ObjPath("man", "lib/assets/objects", "test.obj")
    ], [
      InstanceInfo("man",
          position: vec.Vector3(0, 0, 0), scale: vec.Vector3(5, 5, 5), rotation: vec.Quaternion(1,0,0,0)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    if (!manController.isReady) {
      manController.init();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Vertex Example"),
      ),
      body: Stack(
        children: <Widget>[
          ListenableBuilder(
            listenable: manController,
            builder: (context) {
              if (manController.isReady)
                return GestureDetector(
                    onPanUpdate: (details) {
                      manController.updateXY(details.delta);
                    },
                    child: BlendMask(
                        blendMode: BlendMode.exclusion,
                        child:
                            ObjectRenderer(manController.meshInstances[0])));
              return Container();
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: <Widget>[
      //     FloatingActionButton(
      //       child: Icon(Icons.add),
      //       onPressed: () {
      //       },
      //     ),
      //     FloatingActionButton(
      //       child: Icon(Icons.remove),
      //       onPressed: () {
      //       },
      //     ),
      //     FloatingActionButton(
      //       child: Icon(Icons.replay),
      //       onPressed: () {
      //       },
      //     ),
      //   ],
      // ),
    );
  }

  @override
  void dispose() {
    manController.dispose();
    super.dispose();
  }
}
