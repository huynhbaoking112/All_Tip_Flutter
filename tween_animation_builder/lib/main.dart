import 'package:flutter/material.dart'; 

void main() { 
runApp(const MyApp()); 
} 

class MyApp extends StatelessWidget { 
const MyApp({Key? key}) : super(key: key); 

@override 
Widget build(BuildContext context) { 
	return MaterialApp( 
	title: 'Flutter Demo', 
	theme: ThemeData( 
		primarySwatch: Colors.green, 
	), 
	home: const MyHomePage(), 
	); 
} 
} 

class MyHomePage extends StatefulWidget { 
const MyHomePage({Key? key}) : super(key: key); 

@override 
State<MyHomePage> createState() => _MyHomePageState(); 
} 

class _MyHomePageState extends State<MyHomePage> { 
double targetValue = 100; 

@override 
Widget build(BuildContext context) { 
	return Scaffold( 
		// creating an Appbar 
		appBar: AppBar( 
		title: Text("GeeksforGeeks"), 
		centerTitle: true, 
		), 
		body: Center( 
		// Using TweenAnimationBuilder Widget 
		child: TweenAnimationBuilder( 
			// Tween of double type with begin and the end 
			tween: Tween<double>(begin: 0, end: targetValue), 
			duration: Duration( 
				milliseconds: 2000), // duration which is required parameter 
			// builder function that helps build the animation 
			builder: (BuildContext context, double size, Widget? child) { 
			return IconButton( 
				iconSize: size, 
				color: Colors.orangeAccent, 
				icon: Icon(Icons.flutter_dash), 
				onPressed: () { 
				setState(() { 
					// Logic 
					// targetValue if equal to 100 then make 
					// icon size big to 250 else make it small to 100 
					targetValue = targetValue == 100 ? 250 : 100; 
				}); 
				}, 
			); 
			}, 
		), 
		)); 
} 
} 
