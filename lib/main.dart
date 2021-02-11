import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo/TodoModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider(
          builder: (context) => TodoModel(),
          child: MyHomePage(),
        ));
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String sourceInput;
TodoModel provider;
  @override
  void initState() {
    super.initState();
     provider = Provider.of<TodoModel>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Todo Application",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white70,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "02 : 36 PM",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 45,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "current time",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ), //to show the clock

          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(60)),
                    color: Colors.white),
                child: Consumer<TodoModel>(
                  builder: (context, todo, child) {
                    return ListView.builder(
                        itemCount: todo.taskList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: ListTile(
                              contentPadding: EdgeInsets.only(
                                  left: 32, right: 32, top: 8, bottom: 8),
                              title: Text(
                                todo.taskList[index].title,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                todo.taskList[index].detail,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.check_circle,
                                color: Colors.greenAccent,
                              ),
                            ),
                            margin:
                                EdgeInsets.only(bottom: 8, left: 16, right: 16),
                          );
                        });
                  },
                )),
          ),
          Container(
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(hintText: 'Enter a an item to post'),
              onChanged: (val){
                sourceInput= val;
              },
            ),
          ),
        ],
      ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showDialog(context: context);
          // Provider.of<TodoModel>(context).addTaskInList(sourceInput);
        },
      ),
    );
  }

  void _showDialog({BuildContext context}) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  ChangeNotifierProvider.value(
          value: provider,
          child:  AlertDialog(
            title: new Text("Enter a text"),
            content: new TextField(
              decoration: InputDecoration(hintText: 'Enter a search term'),
              onChanged: (val) {
                sourceInput = val;
              },
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text("Okay"),
                onPressed: () {
                  print('Okay pressed');
                  provider.addTaskInList(sourceInput);
                  Navigator.of(context);
                  // Provider.of<TodoModel>(context).addTaskInList(sourceInput);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}


