import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_db/models/notes_model.dart';
import 'package:hive_flutter/adapters.dart';

import '../../boxes/boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Database"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<NotesModel>();
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                      child: Column(
                        children: [
                          Text(
                            data[i].title.toString(),
                          ),
                          Text(
                            data[i].description.toString(),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // var box = await Hive.openBox('testBox');
          // box.put('name', 'Dhvanit Kholiya');
          // box.put('age', '22');
          // box.put('course', 'Master in Flutter');
          // box.put('details', {
          //   'hobbies': 'cricket',
          //   'gender': 'male',
          // });
          //
          // print(box.get('name'));
          // print(box.get('age'));
          // print(box.get('course'));
          // print(box.get('details')['hobbies']);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add Notes"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Title",
                        ),
                        controller: titleController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Description",
                        ),
                        controller: discriptionController,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Clear"),
                    ),
                    TextButton(
                      onPressed: () {
                        final data = NotesModel(
                            title: titleController.text,
                            description: discriptionController.text);
                        final box = Boxes.getData();
                        box.add(data);

                        data.save();
                        print("==================================");
                        print(box);
                        print("==================================");
                        titleController.clear();
                        discriptionController.clear();

                        Navigator.of(context).pop();
                      },
                      child: Text("Add"),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
// FutureBuilder(
//     future: Hive.openBox('testBox'),
//     builder: (context, snapShots) {
//       return ListTile(
//         leading: Text("Age : ${snapShots.data!.get('age')}"),
//         title: Text("Name : ${snapShots.data!.get('name')}"),
//         trailing: IconButton(
//           onPressed: () {
//             // snapShots.data!.delete('name');
//             // snapShots.data!.delete('age');
//             setState(() {});
//           },
//           icon: const Icon(Icons.delete),
//         ),
//       );
//     })
