import 'package:flutter/material.dart'; 

void main() { 
runApp(MyApp()); 
} 

class MyApp extends StatelessWidget { 
@override 
Widget build(BuildContext context) { 
	return MaterialApp( 
	theme: ThemeData( 
		primarySwatch: Colors.green, // Set the app's primary theme color 
	), 
	debugShowCheckedModeBanner: false, 
	home: ShaderMaskExampleScreen(), 
	); 
} 
} 

class ShaderMaskExampleScreen extends StatelessWidget { 
@override 
Widget build(BuildContext context) { 
	return Scaffold( 
	appBar: AppBar( 
		title: Text('ShaderMask Example'), 
	), 
	body: Center( 
		child: Column( 
		mainAxisAlignment: MainAxisAlignment.center, 
		children: [ 
			// Original Image 
			Image.network( 
			'https://images.pexels.com/photos/2454533/pexels-photo-2454533.jpeg?auto=compress&cs=tinysrgb&w=600', 
			width: 300.0, 
			height: 300.0, 
			fit: BoxFit.cover, 
			), 
			Text("Original Image", 
				style: TextStyle(fontWeight: FontWeight.bold)), 

			SizedBox(height: 20.0), // Add some spacing between the images 

			// Image with ShaderMask 
			ShaderMask( 
			shaderCallback: (Rect bounds) { 
				// Create a linear gradient shader for the mask 
				return LinearGradient( 
				colors: [Colors.red, Colors.blue], 
				stops: [0.1, 0.9], 
				begin: Alignment.topCenter, 
				end: Alignment.bottomCenter, 
				).createShader(bounds); 
			}, 
			child: Image.network( 
				'https://images.pexels.com/photos/2454533/pexels-photo-2454533.jpeg?auto=compress&cs=tinysrgb&w=600', 
				width: 300.0, 
				height: 300.0, 
				fit: BoxFit.cover, 
			), 
			), 
			Text( 
			"Shadered Image", 
			style: TextStyle(fontWeight: FontWeight.bold), 
			) 
		], 
		), 
	), 
	); 
} 
} 
