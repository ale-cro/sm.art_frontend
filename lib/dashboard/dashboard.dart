import 'package:datatable_con_adaptive/dashboard/timbrature/future_timbrature.dart';
import 'package:datatable_con_adaptive/dashboard/operaio/future_operai.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../FormFactor.dart';
import 'dashboard_provider.dart';

/// Classe dedicata alla gestione della DashBoard.
///La dashboard è composta da due componenti: la lista degli operai e la lista delle timbrature.
/// Lo scopo della dashboard è quello di far visualizzare la lista degli operai e la lista delle timbrature a seconda dell'operaio cliccato.
/// Estendendo StatefulWidget, Dashboard provvider deve definire uno _State

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("dashboard"),
        ),
        body: LayoutBuilder(builder: (context, constraints) {

          //Se si preferisce realizzare layout separati a seconda della dimensione dello schermo (com'è stato fatto nella homepage).
          /*if(MediaQuery.of(context).size.width > FormFactor.desktop){
            return const WideLayout();
          }else{
            return const NarrowLayout();
          }*/
          return const WideLayout();
    })
    );
  }
}

///Classe dedicata alla gestione del Layout della dashboard (sia desktop che mobile)
class WideLayout extends StatefulWidget {
  const WideLayout({super.key});

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  late String cf;
  bool isLargeScreen = true;

  @override
  Widget build(BuildContext context) {

    //il campo cf osserva il campo cfProvider di DashboardProvdier, di consequenza ogni cambiamento di cfProvider verrà eseguito a cf
   cf = context.watch<DashboardProvider>().cfProvider;
   if(MediaQuery.of(context).size.width > FormFactor.desktop){
     isLargeScreen = true;
   }else{
     isLargeScreen = false;
   }
   return Row(
      children: [
        const Expanded(
          flex: 2,
          child: FutureOperai(),
        ),
        //https://medium.com/flutter-community/developing-for-multiple-screen-sizes-and-orientations-in-flutter-fragments-in-flutter-a4c51b849434
        //Se lo schermo è largo n pixel allora aggiungo un widget Expanded che verrà usato per posizionare il widget di FutureTimbrature dedicato al fetch della lista delle timbrature di un certo cf
        // (se non viene selezionato nessun operaio viene inserito un widget placeholder)
        isLargeScreen ? Expanded(
          flex: 2,
          child: cf == "" ?  const Placeholder(child: Text("Selezionare Operaio"),) :   FutureTimbrature(cf: cf)
        ) :  Container(),
        /*
        TextButton(onPressed: (){
          createOperaio("test", "test");
        }, child: const Text("post"))*/
      ],
    );
  }
}

///Se si vuole creare un layout dedicato per mobile
/*
class NarrowLayout extends StatefulWidget {
  const NarrowLayout({super.key});

  @override
  State<NarrowLayout> createState() => _NarrowLayoutState();
}

class _NarrowLayoutState extends State<NarrowLayout> {
  @override
  Widget build(BuildContext context) {
    return const FutureOperai();
  }
}*/


