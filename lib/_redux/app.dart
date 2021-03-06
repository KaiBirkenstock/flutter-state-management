import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_state_management/_redux/_actions.dart';
import 'package:flutter_state_management/_redux/_reducers.dart';
import 'package:flutter_state_management/_redux/_state.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  final store = Store<AppState>(appReducer, initialState: AppState.initialState());

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Flutter Redux Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Page(title: 'Flutter Redux Demo'),
        ));
  }
}

class Page extends StatelessWidget {
  Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListViewWidget(),
        floatingActionButton: StoreConnector<AppState, VoidCallback>(
          converter: (Store<AppState> store) {
            return () => store.dispatch(AddItemAction(payload: DateTime.now().toString()));
          },
          builder: (BuildContext context, VoidCallback onPressedCallback) {
            return FloatingActionButton(
              onPressed: onPressedCallback,
              tooltip: 'Add',
              child: Icon(Icons.add),
            );
          },
        ));
  }
}

class ListViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<String>>(
      converter: (Store<AppState> store) => store.state.items,
      builder: (BuildContext context, List<String> items) {
        return ListView.builder(
            padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(items[index]),
              );
            });
      },
    );
  }
}
