import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'FormFactor.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;
    //Layout Builder will rerun the build method when ever the contrainst passed to it from its parent cheange
    //it needs to be pretty high in the widget tree.
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
          if (screenSize.width > FormFactor.tablet) return _buildDesktop(context, constrains);
          return _buildMobile(context);
        },
      ),
    );
  }

  Widget _buildDesktop(BuildContext context, BoxConstraints constraints) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: Container(
            //aggiunto solo per inserire la decorazione intorno al Widget Column, che è child di Container
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 20,
                )),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                   const FittedBox(
                     fit: BoxFit.fill,
                     child: Text(
                      "Homepage",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
                  ),
                   ),
                  Container(
                    //aggiunto solo per inserire la decorazione intorno al Widget Row, che è child di Column
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.pinkAccent,
                          width: 20,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //mainAxisSize : MainAxisSize.min,  //Minimize the amount of free space along the main axis, subject to the incoming layout constraints. Cos' la mia row non copre tutta la larghezza della pagina
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              context.go('/dashboard');
                            },
                            child: const Text("Vai a tabella Operai")),
                        ElevatedButton(
                            onPressed: () {
                              context.go('/register');
                            },
                            child: const Text("Register")),
                        ElevatedButton(
                            onPressed: () {
                              context.go('/login');
                            },
                            child: const Text("login")),
                        ElevatedButton(
                            onPressed: () {
                              context.go('/changePass');
                            },
                            child: const Text("change password")),
                        ElevatedButton(
                            onPressed: () {
                              context.go('/gestione_utenti');
                            },
                            child: const Text("gestione utenti"))
                      ],
                    ),
                  )
                ]),
          ),
        );
      },
    );
  }
  Widget _buildMobile(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
              border: Border.all(
              color: Colors.pinkAccent,
              width: 20,
            )
        ),
        //padding: EdgeInsets.all(100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Homepage",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    context.go('/dashboard');
                  },
                  child: const Text("Vai a tabella Operai")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    context.go('/gestione_utenti');
                  },
                  child: const Text("Gestione Utenti")),
            ),
          ],
        ),
      ),
    );
  }
}
