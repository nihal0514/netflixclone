import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix/bloc/netflix_bloc.dart';
import 'package:flutter_netflix/screens/profile_selection.dart';

class AddProfile extends StatefulWidget {
  const AddProfile({super.key});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  final profileTextController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    profileTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Profile"),
        actions: [
          InkWell(
            onTap: (){
              context
                  .read<AddUserBloc>().add(addUserEvent(profileTextController.text));
              Navigator.push(context, MaterialPageRoute( builder: (context) => const ProfileSelectionScreen()));

            },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                  child: Center(child: Text("Save",style: TextStyle(fontSize: 20),))))
        ],
      ),
      body: Column(
        children: [

            Container(
              margin: EdgeInsets.all(50),
              child: TextField(
                controller: profileTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add Profile',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
