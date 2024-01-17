import 'package:datatable_con_adaptive/dashboard/timbrature/timbratura.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///Clase che si occupa di visualizzare la lista delle timbrature ottenute da un certo CF
///@param timbrature: lista di timbrature eseguite da un CF
class TimbratureList extends StatefulWidget {
  const TimbratureList({super.key, required this.timbrature});
  final List<Timbratura> timbrature;

  @override
  State<TimbratureList> createState() => _TimbratureListState();
}

class _TimbratureListState extends State<TimbratureList> {
  final ScrollController _scrollController = ScrollController();

  //bool per far apparire pulsante per tornare all'inizio della lista
  bool _showBackToTopButton = false;

  //se si stanno caricando i nuovi dati allora aggiungo il child child: CircularProgressIndicator(),
  bool isLoading = false;

  //bool per visuallizare alter se non ci sono più timbrature paginate
  bool pageEnd = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener((_scrollButton));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }


  void _scrollButton() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _showBackToTopButton = true; // show the back-to-top button
    } else {
      _showBackToTopButton = false; // hide the back-to-top button
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scrollbar(
      controller: _scrollController,
        child: Column(
          children: [
            SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: <Widget>[
                    DataTable(
                      columns: const [
                        DataColumn(
                          label: Text('idTimbrature'),
                        ),
                        DataColumn(
                          label: Text('entrata'),
                        ),
                      ],
                      rows: List.generate(
                        widget.timbrature.length,
                        (index) {
                          widget.timbrature[index];
                          return DataRow(cells: [
                            DataCell(
                              Text(widget.timbrature[index].idtimbratura),
                            ),
                            DataCell(
                              Text(widget.timbrature[index].entrata),
                            ),
                          ]);
                        },
                      ).toList(),
                    ),

                Visibility(
                    visible: isLoading, child: const CircularProgressIndicator()),
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
            ElevatedButton(onPressed: () {context.go('/dashboard');}, child: const Text('Go back!'),)
          ],
        ),
    );
  }
}
