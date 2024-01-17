import 'package:datatable_con_adaptive/dashboard/dashboard_provider.dart';
import 'package:datatable_con_adaptive/dashboard/operaio/operaio_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'operaio.dart';
import 'package:flutter/material.dart';

///Classe che si occupa di visulizzare la lista degli operai fetchati da FutureOperai
///@param: operai = lista degli operai fetchati da FutureOperai
///        isLargeScreen = bool che definisce se siamo in modalità desktop
class OperaioList extends StatefulWidget {
  const OperaioList(
      {super.key, required this.operai, required this.isLargeScreen});

  final List<Operaio> operai;
  final bool isLargeScreen;

  @override
  State<OperaioList> createState() => _OperaioListState();
}

class _OperaioListState extends State<OperaioList> {
  //cf dell'operaio cliccato
  late String cf;

  //numero della pagina iniziale per paginazione
  int page = 1;

  //numero degli elementi da prendere dalla paginazione
  final int size = 20;

  //lunghezza della lista degli operai (servirà per controllare se ci sono altri dati da fectahre)
  int operaiLenght = 0;

  //bool per visuallizare se non ci sono più utenti paginati
  bool pageEnd = false;

  //widget per definire il comportamento dello scroll della nostra lista, per il SingelChildScrollView
  final ScrollController _scrollController = ScrollController();

  //variabili per ordianmento della tabella
  int sortColumnIndex = 0;
  bool isAscending = true;

  //bool per visulizzare il child: CircularProgressIndicator(), per dare l'illusione che stia caricando
  bool isLoading = false;

  //prima di assegnare lo scroll controller bisogna aggiunere per forza un listener.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener((_onScroll));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  //funzione per eseguire il fetching dei nuovi operai da aggiungere alla lista
  Future fetchNewOperai(columnIndex, ascending) async {
    page++;
    operaiLenght = widget.operai.length;
    //paginazione dei nuovi operai in pagina n+1
    widget.operai.addAll((await fetchPaging(page, size)));

    //Se bisogna cambiare i valori delle variabili di un _State, bisogna chiamare setState
    setState(() {
      //Controllo che definisce che non ci sono più operai da fetchare dal db
      //viene eseguito un confronto tra la lunghezza della lista prima del fetch e dopo il fetch
      if (operaiLenght == widget.operai.length) {
        pageEnd = true;
      }
      //esecuzione sorting dopo aver eseguito il fetching dei dati nuovi, per mantenere l'ordinamento dei dati della tabella
      onSort(columnIndex, ascending);
      isLoading = false;
    });
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  //funzione che definisce quando triggerare il lazy loading tramite scroll in basso
  //quando si arriva quasi alla fine della lista viene eseguito il lazy loading.
  _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        isLoading = true;
      });
      fetchNewOperai(sortColumnIndex, isAscending);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      //widget per visulizzare scrollbar
      child: Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        //visto che SingleChildScrollView è wrappato all'interno di uno ScrollBar, non basta assegnare lo srollcontroller solo al figlio, devo assegnarlo anche al padre (ScrollBar), ogni elemento scroll deve avere un controller, altrimenti viene segnalato errore
        child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                DataTable(
                  sortAscending: isAscending,
                  sortColumnIndex: sortColumnIndex,
                  columns: [
                    DataColumn(label: const Text('cf'), onSort: onSort),
                    DataColumn(label: const Text('nome'), onSort: onSort),
                  ],
                  rows: List.generate(
                    widget.operai.length,
                    (index) {
                      widget.operai[index];
                      return DataRow(
                          cells: [
                            DataCell(Text(widget.operai[index].cf), onTap: () {
                              //Modalità desktop = viene aggiornato il cf del DashboardProvvider
                              //modalita Mobile = viene aggiornato il cf del DashboardProvvider e viene eseguito il routing al FutureTimbrature
                              context
                                  .read<DashboardProvider>()
                                  .changeCF(widget.operai[index].cf);
                              if (widget.isLargeScreen == false) {
                                context.go('/future_timbratura');
                              }
                            }),
                            DataCell(
                              Text(widget.operai[index].nome),
                            ),
                          ],
                          onLongPress: () => _show(
                              context,
                              widget.operai[index].nome,
                              widget.operai[index].cf));
                    },
                  ).toList(),
                ),
                Visibility(
                    visible: isLoading,
                    child: const CircularProgressIndicator()),
                Visibility(
                    visible: !isLoading,
                    child: TextButton(
                        onPressed: onPressed,
                        child: Text('utenti : $size , pagina : $page'))),
                FloatingActionButton(
                    onPressed: _scrollToTop,
                    child: const Icon(Icons.arrow_upward)),
                Visibility(
                    visible: pageEnd,
                    child: AlertDialog(
                      title: const Text('AlertDialog Title'),
                      content: const Text('AlertDialog description'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }

//funzione per eseguire sorting sc/desc a seconda della colonna cliccata
  void onSort(int columnIndex, bool ascending) {
    switch (columnIndex) {
      //order by cf
      case 0:
        if (ascending) {
          widget.operai.sort((op1, op2) => op1.cf.compareTo(op2.cf));
        } else {
          widget.operai.sort((op1, op2) => op2.cf.compareTo(op1.cf));
        }
      //order by nome
      case 1:
        if (ascending) {
          widget.operai.sort((op1, op2) => op1.nome.compareTo(op2.nome));
        } else {
          widget.operai.sort((op1, op2) => op2.nome.compareTo(op1.nome));
        }
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  //funzione per eseguire fetching tramite pulsante (al momento il fetching viene eseguito tramite scroll in basso)
  void onPressed() {
    setState(() {
      isLoading = true;
    });
    fetchNewOperai(sortColumnIndex, isAscending);
  }

  /*funzione che ritorna una finestra alla cupertino (iOS), legato al onLongPressed di una riga del nome*/
  void _show(BuildContext ctx, String nome, String cf) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => CupertinoActionSheet(
              title: const Text("onLongPress"),
              message: Text("Nome Operio : $nome, Codice Fiscale : $cf"),
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      context.go('/future_timbratura', extra: cf);
                    },
                    isDefaultAction: true,
                    child: const Text('Visualliza timbrature')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      /*...*/
                    },
                    isDefaultAction: true,
                    child: const Text('Option #2')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      /*...*/
                    },
                    isDefaultAction: true,
                    child: const Text('Option #3')),
              ],
              cancelButton: CupertinoActionSheetAction(
                  onPressed: () => _close(ctx),
                  isDestructiveAction: true,
                  child: const Text('Close')),
            ));
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }
}
