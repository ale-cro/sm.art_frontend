import 'package:datatable_con_adaptive/FormFactor.dart';
import 'package:datatable_con_adaptive/dashboard/operaio/operaio.dart';
import 'package:datatable_con_adaptive/dashboard/operaio/operaio_api.dart';
import 'package:datatable_con_adaptive/dashboard/operaio/operaio_list.dart';
import 'package:flutter/material.dart';

///Classe che si occupa di eseguire il primo fecth degli operai
/// https://docs.flutter.dev/cookbook/networking/fetch-data

class FutureOperai extends StatefulWidget {
  const FutureOperai({super.key});

  @override
  State<FutureOperai> createState() => _FutureOperaiState();
}

class _FutureOperaiState extends State<FutureOperai> {

  ///Variabili per definire dimensione e pagina per la paginazione dei dati
  final int size = 20;
  int page = 1;

  late Future<List<Operaio>> operaiList;
  bool isLargeScreen = true;

  ///Called when this object is inserted into the tree.
  ///The framework will call this method exactly once for each State object it creates.
  ///Funzione che viene eseguita ogni volta che viene chiamato FutureOperai.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///fetch paginato degli operai, viene eseguito subito dopo quando viene chiamato FutureOperai
    operaiList = fetchPaging(page, size);
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > FormFactor.desktop) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }
    return FutureBuilder<List<Operaio>>(
      //That is where FutureBuilder comes in. You can use it when you have a future, to display one thing while you are waiting for it (for example a progress indicator) and another thing when it's done (for example the result).
      future: operaiList,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          return OperaioList(
              operai: snapshot
                  .data!,
          isLargeScreen: isLargeScreen,);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
