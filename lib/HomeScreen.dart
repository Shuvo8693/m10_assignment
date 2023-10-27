import 'package:flutter/material.dart';
import 'package:m10_assignment/Todo_Class.dart';

import 'UpdateTodoModal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDo> todoList = [];
  TextEditingController todoTiTEController=TextEditingController();
  TextEditingController todoDeTEController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 240,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5),
                          child: TextFormField(
                            controller: todoTiTEController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              hintText: 'Types others name of Allah..',
                              labelText: 'Name',
                            ),
                            validator: (String? value){
                              if(value?.trim().isEmpty ?? true){
                                return 'Enter Valid Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5),
                          child: TextFormField(
                            controller: todoDeTEController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                              hintText: 'Meaning Of the Name..',
                              labelText: 'Description',
                            ),
                            validator: (String? value){
                              if(value?.trim().isEmpty ?? true){
                                return
                                    'Enter Valid Description';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton( ///------
                              onPressed: () {
                                if(_formKey.currentState!.validate()){
                               ToDo todoEB=ToDo(name:(todoTiTEController.text.trim()),
                                   description:(todoDeTEController.text.trim()));
                                   addTodo(todoEB);
                                }
                              }, child: const Text('Add')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Flexible(
            child: SizedBox(
              height: 345,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final ToDo todol=todoList[index];
                    return ListTile(
                      title: Text(todol.name), ///<<<<<<
                      subtitle: Text(todol.description),///<<<<<<
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      onLongPress: (){
                        showDialog(context: (context),
                            builder: (context){
                          return
                              AlertDialog(
                                title: const SizedBox(
                                  height: 70,
                                    child: Text('Alert')),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                        showModalBottomSheet(context: (context),
                                            isScrollControlled: true,   /// This isScrollControlled: True, is for Full visibility after Keyboard Popup,but need padding mediaQuery ViewInsets.bottom
                                            builder: (context){
                                          return /// modalEB constructor need Two String Argument to passing data
                                               UpdateTodo(todol: todol,
                                                 modalEB: (String updateName ,String updateDescription ) {
                                                 updateTodo(index, updateName, updateDescription);
                                                 },); ///------
                                            },);
                                      },child: const Text('Edit',style: TextStyle(color: Colors.blueAccent),),
                                    ),
                                    InkWell( ///-----
                                      onTap: (){
                                        removeTodo(index);
                                      },child: const Text('Delete',style: TextStyle(color: Colors.blueAccent)),
                                    ),
                                  ],
                                ),

                              );
                            });
                      },
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         InkWell(
                           borderRadius: BorderRadius.circular(12),
                           onTap: (){},child: const Icon(Icons.arrow_forward,size: 25,),
                         )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(height: 1,),
                  itemCount: todoList.length),
            ),
          ),
        ],
      ),
    );
  }
  void addTodo(ToDo toDo){
    todoList.add(toDo);
    setState(() {});
  }
  void removeTodo(int index){
    todoList.removeAt(index);
    setState(() {});
  }
  void updateTodo(index,String updateName,String updateDescription){
    todoList[index].name= updateName;
    todoList[index].description= updateDescription;
    setState(() {});
  }
 
}


