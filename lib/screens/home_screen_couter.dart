
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen>{
  void increase () {
    counter++;
    setState(() {});
  }

  void decrease(){
    counter--;
    setState(() {});
  }

  void reset() {
    counter = 0;
    setState(() { } );
  }
  int counter = 10;

  @override
  Widget build(BuildContext context) {
    const TextStyle fontSize30 = TextStyle(fontSize: 30);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador'),
        elevation: 2,
      ),
      // backgroundColor: Colors.lightBlue,
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Item 1', style: fontSize30,),
            Text('El numero es $counter', style: fontSize30,)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingActions(
        increaseFn: increase,
        decreaseFn: decrease,
        resetFn: reset,
      )
    );
  }
}

class CustomFloatingActions extends StatelessWidget {
  final Function increaseFn;
  final Function decreaseFn;
  final Function resetFn;

  const CustomFloatingActions({
    Key? key,
    required this.increaseFn,
    required this.decreaseFn,
    required this.resetFn
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          onPressed: () => decreaseFn(),
          child: const Icon(Icons.exposure_minus_1_outlined),
        ),
        // const SizedBox(width: 20,),
        FloatingActionButton(
          onPressed: () => resetFn(),
          child: const Icon(Icons.lock_reset),
        ),
        // const SizedBox(width: 20,),
        FloatingActionButton(
          onPressed: () => increaseFn(),
          child: const Icon(Icons.exposure_plus_1_outlined),
        ),
      ],
    );
  }

}