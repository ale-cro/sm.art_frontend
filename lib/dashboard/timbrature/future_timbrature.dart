import 'package:datatable_con_adaptive/dashboard/timbrature/timbratura.dart';
import 'package:datatable_con_adaptive/dashboard/timbrature/timbrature_api.dart';
import 'package:datatable_con_adaptive/dashboard/timbrature/timbrature_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:datatable_con_adaptive/dashboard/dashboard_provider.dart';

///Classe che si occupa del fetching delle timbrature dato un CF
///@param: cf = codice fiscale ottenuto eseguendo il click su un operaio della lista _OperaioListState
class FutureTimbrature extends StatefulWidget {
  const FutureTimbrature({super.key, required this.cf});
  final String cf;

  @override
  State<FutureTimbrature> createState() => _FutureTimbratureState();
}

class _FutureTimbratureState extends State<FutureTimbrature> {

  late String cf;
  late Future<List<Timbratura>> timbraturaList;
  bool isLoading = false;

  @override
  void initState() {
    cf = widget.cf;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  /*called after initState and whenever the dependencies change thereafter*/
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (cf != widget.cf) {
      isLoading = true;
    }
    cf = context.watch<DashboardProvider>().cfProvider;
    timbraturaList = fetchTimbratureFromCF(cf);
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Timbrature di CF : $cf"),
          FutureBuilder<List<Timbratura>>(
            //That is where FutureBuilder comes in. You can use it when you have a future, to display one thing while you are waiting for it (for example a progress indicator) and another thing when it's done (for example the result).
            future: timbraturaList,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                if (isLoading == true) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return TimbratureList(
                      timbrature: snapshot
                          .data!); //Se il builder torna dei dati compatibili (in questo caso no visto che il json non è pasabile cause dei tag presenti all'interno di esso come pagable) allora genero un nuovo UserList e popolo la lista user con i dati presenti nello snapshot
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
