import 'package:flutter/material.dart';
import 'data/Transaction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyHsaRewardsApp());

class MyHsaRewardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue[900]), home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  // final _listOfTransactions = <Transaction>[];

  Future<List<Transaction>> fetchTransactions() async {
    const githubURL =
        "https://raw.githubusercontent.com/coherentcloud/coherentcloud.github.io/master/transactions.json";
    // var mockerURL = 'https://my.api.mockaroo.com/transactions.json?key=d0593b50';

    Uri gitHubUri = Uri.parse(githubURL);
    var response = await http.get(gitHubUri);

    var transactions = <Transaction>[];

    if (response.statusCode == 200) {
      var transactionsJson = json.decode(response.body);
      for (var t in transactionsJson) {
        transactions.add(Transaction.fromJson(t));
      }
    }
    print(transactions.length);
    return transactions;
  }

  Widget _buildList() {
    return Container(
      child: FutureBuilder(
          future: fetchTransactions(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(snapshot.data[index].description));
                  });
            } else {
              return Container(child: Center(child: Text('Loading...')));
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My HSA Rewards App'),
        ),
        body: _buildList());
  }
}
