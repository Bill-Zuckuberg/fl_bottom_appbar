import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom AppBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomAppbarExamble(
          title: 'Bottom AppBar and Floating App Bottom (FAB)'),
    );
  }
}

class BottomAppbarExamble extends StatefulWidget {
  const BottomAppbarExamble({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BottomAppbarExamble> createState() => _BottomAppbarExambleState();
}

class _BottomAppbarExambleState extends State<BottomAppbarExamble> {
  FloatingActionButtonLocation _fablocation =
      FloatingActionButtonLocation.endDocked;

  bool _isBottomBarnotched = false;
  bool _isFabMini = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          ListTile(
            title: const Text('FloatingActionButtom posittion'),
            trailing: DropdownButton<FloatingActionButtonLocation>(
              value: _fablocation,
              onChanged: (FloatingActionButtonLocation? newVal) {
                if (newVal != null) {
                  setState(() {
                    _fablocation = newVal;
                  });
                }
              },
              items: const [
                DropdownMenuItem(
                  child: Text('centerFloat'),
                  value: FloatingActionButtonLocation.centerTop,
                ),
                DropdownMenuItem(
                  child: Text('endFloat'),
                  value: FloatingActionButtonLocation.endFloat,
                ),
                DropdownMenuItem(
                  child: Text('endDocked'),
                  value: FloatingActionButtonLocation.endDocked,
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('BottomAppBar notch: '),
            trailing: Switch(
              value: _isBottomBarnotched,
              onChanged: (bool val) {
                setState(() {
                  _isBottomBarnotched = val;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Mini FAB: '),
            trailing: Switch(
              value: _isFabMini,
              onChanged: (bool val) {
                setState(() {
                  _isFabMini = val;
                });
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: _isFabMini,
        onPressed: () =>
            Fluttertoast.showToast(msg: 'Dummy floating action bottom'),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: _fablocation,
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  BottomAppBar _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      shape: _isBottomBarnotched ? const CircularNotchedRectangle() : null,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: <Widget>[
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => Container(
                          alignment: Alignment.center,
                          height: 200,
                          child: const Text('Dummy bottom sheet'),
                        ));
              },
              icon: const Icon(Icons.menu)),
          IconButton(
              onPressed: () =>
                  Fluttertoast.showToast(msg: "Dummy search action"),
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () => Fluttertoast.showToast(msg: 'Dummy menu action'),
              icon: const Icon(Icons.more_vert))
        ],
      ),
    );
  }
}
