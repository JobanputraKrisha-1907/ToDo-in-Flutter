import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/pages/AddToDo.dart';
import 'package:todo_list/pages/resue.dart';
import 'package:todo_list/pages/view_data.dart';
//import 'package:todo_list/pages/signupPage.dart';
import '../Custom/ToDoCard.dart';
import '../service/Auth_Services.dart';
//import 'package:todo_list/Custom/ToDoCard.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);


  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection("Todo").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/profile.jpg"),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: const PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                  "Monday 21",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
            preferredSize: Size.fromHeight(35),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                    Icons.home,
                    size: 32,
                  color: Colors.white,
                ),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (builder)=>AddToDoPage()));
                },
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigoAccent,
                        Colors.purple,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              label: "add",
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 32,
                color: Colors.white,
              ),
              label: "settings",
            ),
          ],
      ),

      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData)
            {
              return Center(child: CircularProgressIndicator());
            }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                 IconData iconData = Icons.alarm;
                 Color iconColor = Colors.red;
                Map<String,dynamic> document =
                snapshot.data!.docs[index].data() as Map<String,dynamic>;
                switch(document["Category"])
                {
                  case "Run":
                  iconData = Icons.run_circle_outlined;
                  iconColor = Colors.red;
                  break;
                  case "Workout":
                    iconData = Icons.alarm;
                    iconColor = Colors.teal;
                    break;
                  case "Work":
                    iconData = Icons.lock_clock;
                    iconColor = Colors.deepOrange;
                    break;
                  case "Food":
                    iconData = Icons.local_grocery_store;
                    iconColor = Colors.blueAccent;
                    break;
                  // case "Run":
                  //   iconData = Icons.run_circle_rounded;
                  //   iconColor = Colors.teal;
                  //   break;
                  default:
                    iconData = Icons.run_circle_outlined;
                    iconColor = Colors.red;
                }
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder)=>ViewData(
                      document: document,
                        //id:snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
              },
              child: reuseCard(
                document["title"]==null?"Hey there":document["title"],
                Colors.white,
                "21:18",
                iconData,
                iconColor,
              ),
            );
          });
        }
      ),
    );
  }
}


// for future use
// IconButton(icon: Icon(Icons.logout), onPressed: () async{
//             await authClass.logout();
//             Navigator.pushAndRemoveUntil(
//                 context, MaterialPageRoute(builder: (builder) => signupPage()),
//                     (route) => false);
//           })
