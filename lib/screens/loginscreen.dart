import 'package:flutter/material.dart';

final TextEditingController userCtrl = TextEditingController();
final TextEditingController passCtrl = TextEditingController();
final String name = "admin";
final String password = "admin";

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(title: const Text("Login"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: 40),
            TextField(
              controller: userCtrl,
              decoration: const InputDecoration(
                labelText: "Usuario",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            const SizedBox(height: 16),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                String userCtrlText = userCtrl.text;
                String passCtrlText = passCtrl.text;

                if (userCtrlText == name && passCtrlText == password) {
                  // Aquí no validamos nada, solo navegamos al juego
                  Navigator.pushReplacementNamed(context, '/game');
                  return;
                }
                // Aquí no validamos nada, solo navegamos al juego
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              child: const Text(
                "Ingresar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
