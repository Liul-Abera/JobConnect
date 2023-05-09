import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// // class Posted_jobs extends StatefulWidget {
// //   const Posted_jobs({Key? key}) : super(key: key);

// //   @override
// //   State<Posted_jobs> createState() => _Posted_jobsState();
// // }

// // class _Posted_jobsState extends State<Posted_jobs> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Center(
// //         child: Text('posted jobs'),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// //void main() => runApp(Posted_jobs());

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/jobs_model.dart';

class Posted_jobs extends StatefulWidget {
  @override
  _Posted_jobsState createState() => _Posted_jobsState();
}

class _Posted_jobsState extends State<Posted_jobs> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Employer Dashboard'),
        backgroundColor: Colors.blue[900],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('employer')
            .doc(getCurrentUserUid())
            .collection('job posting')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return SafeArea(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 450,
                    child: new ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: new ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              style: ListTileStyle.drawer,
                              leading: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              //  leading: new Text(document['job category']),
                              title: new Text(document['title']),
                              subtitle: new Text(document['description']),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

// class Posted_jobs extends StatefulWidget {
//   @override
//   _Posted_jobsState createState() => _Posted_jobsState();
// }

// class _Posted_jobsState extends State<Posted_jobs> {
//   String getCurrentUserUid() {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       return user.uid;
//     } else {
//       return '';
//     }
//   }

//   Future<List<JobPost>> getJobPostList() async {
//     List<JobPost> JobPostList = [];
//     QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//         .instance
//         .collection('employer')
//         .doc(getCurrentUserUid())
//         .collection('JobPost posting')
//         .get();

//     snapshot.docs.forEach((doc) {
//       JobPost job = JobPost.fromJson(doc.data());
//       JobPostList.add(job);
//       print('the title of the job is :${JobPostList[0].title}');
//     });

//     return JobPostList;
//   }

//   late Future<List<JobPost>> _jobListFuture;

//   @override
//   void initState() {
//     super.initState();
//     _jobListFuture = getJobPostList();
//     // print('the title of the job is :${_jobListFuture[0].title}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Employer Dashboard'),
//       ),
//       body: FutureBuilder<List<JobPost>>(
//         future: _jobListFuture,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 JobPost job = snapshot.data![index];
//                 return ListTile(
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.black, width: 1),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   title: Text(job.title),
//                   subtitle: Text(job.description),
//                   trailing: Text('\$${job.salary}'),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }
