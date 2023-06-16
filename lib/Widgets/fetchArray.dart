import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class FetchArray extends StatefulWidget {
  @override
  _FetchArrayState createState() => _FetchArrayState();
}

class _FetchArrayState extends State<FetchArray> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('extra').snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          final data = snapshot.requireData;
          // List<String> extraa = List.from(snapshot.data!.docs!['extras'])

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              List<String> extraa = List.from(snapshot.data!.docs[index]['extras']);
              return ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(8),
                children: extraa
                    .map(
                      (ingredient) => Card(
                    color: Colors.black54,
                    child: Center(
                      child: Text(
                        ingredient,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                )
                    .toList(),
              );

            },
          );
        },
      ),
    );
  }
}
