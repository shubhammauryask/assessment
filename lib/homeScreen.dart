import 'package:flutter/material.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  var textController = TextEditingController();

  var list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        title: Text("TODO APP"),
        backgroundColor: Colors.blueAccent,


      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.cover)
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Text...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    )),
                SizedBox(width: 10,),
                ElevatedButton(onPressed: (){
                  if(textController.text.toString() !=""){
                    list.insert(0, textController.text.toString());
                    textController.clear();
                    setState(() {

                    });
                  }
                }, child: Text("Add"))
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      title: Text(list[index]),
                      trailing: IconButton(onPressed: (){
                        list.removeAt(index);
                        setState(() {

                        });
                      }, icon: Icon(Icons.delete_forever, size: 25,), color: Colors.red,),
                    );
                })
              ),
            )
          ],
        )
      ),

    );
  }
}
