import 'package:flutter/material.dart';
import 'package:m10_assignment/Todo_Class.dart';

class UpdateTodo extends StatefulWidget {
  const UpdateTodo({
    super.key, required this.todol, required this.modalEB, /*required this.modalEB2*/
  });
  final ToDo todol;
  final Function(String,String) modalEB;  /// Two Argument Called from here for passing data


  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  ///Update or Edit Screen need this late , initState() method.
  late TextEditingController updateTiTEController;
  late TextEditingController updateDeTEController;
  @override
  void initState() {  ///The reason for using late and initializing them in initState is to ensure that they are ready for use when the widget is actually built and displayed on the screen, preventing null pointer exceptions or other issues.
    updateTiTEController=TextEditingController(text: widget.todol.name);
    updateDeTEController=TextEditingController(text: widget.todol.description);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 240,
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 5,right: 5),
              child: TextFormField(
                controller: updateTiTEController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 5,right: 5),
              child: TextFormField(
                controller: updateDeTEController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
              ),
            ),
           const SizedBox(height: 25,),
            ElevatedButton(onPressed: (){  ///------- Pass Two Argument through modalEB Constructor, statefulwidget e kono instance create korle seta call korte hola widget lika korte hoy.
              widget.modalEB(updateTiTEController.text.trim(),updateDeTEController.text.trim());
              Navigator.pop(context);
            }, child: const Text('Edit Done')),
          ],
        ),
      ),
    );
  }
}