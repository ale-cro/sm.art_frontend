import 'package:datatable_con_adaptive/gestione_utenti/utente.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
///Classe che si occupa di visulizzare la lista degli utenti e di modificare i loro dati.
class UsersList extends StatefulWidget{
  const UsersList({super.key, required this.users});

  final List<Utente> users;

  @override
  State<UsersList> createState() => _UsersListState();
  }

class _UsersListState extends State<UsersList> {

  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;

  get onPressed => null;

  bool pageEnd = false;
  
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener((_onScroll));
  }

  _onScroll() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        isLoading = true;
      });
      //getUsers(sortColumnIndex, isAscending);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        //visto che il mio SingleChildScrollView è wrappato all'interno di uno ScrollBar, non basta assegnare lo srollcontroller solo al figlio, devo assegnarlo anche al padre, ogni elemento scroll deve avere un controller se no dopo mi cacia errore dicendo che un elemento scroll non
        child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                DataTable(
                  columns: const [
                    DataColumn(label: Text('idutente')),
                    DataColumn(label: Text('nome')),
                    DataColumn(label: Text('password')),
                    DataColumn(label: Text('email')),
                    DataColumn(label: Text('')),
                    DataColumn(label: Text('')),
                  ],
                  rows: List.generate(
                    widget.users.length,
                        (index) {
                      widget.users[index];
                      return DataRow(cells: [
                        DataCell(
                            Text(widget.users[index].idutente.toString()),
                            )
                        ,
                        DataCell(
                          Text(widget.users[index].nome),
                        ),
                        DataCell(
                          Text(widget.users[index].email),
                        ),
                        DataCell(
                          Text(widget.users[index].password),
                        ),
                        DataCell(TextButton(onPressed: (){

                        }, child: const Text("Elimina"))),
                        DataCell(TextButton(onPressed: (){
                          context.go('/modifica_utente/${widget.users[index].idutente}', extra : widget.users[index].idutente);
                        }, child: const Text("Modifica"))),
                      ]);
                    },
                  ).toList(),
                ),
                Visibility(
                    visible: isLoading, child: const CircularProgressIndicator()),
                Visibility(visible: pageEnd, child: AlertDialog(
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
            )
        ),
      ),
    );


  }
}



