import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prizorsdk_flutter/prizorsdk_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'PrizorSDK Example';

    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NavigationPage(),
    );
  }
}

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PrizorSDK Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text("Root Page Example"),
              onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const MyRootHomePage(
                        title: "PrizorSDK Example",
                      ),
                    ),
                  );
              },
            ),
            ElevatedButton(
              child: const Text("Navigation Page Example"),
              onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const MyHomePage(
                        title: "PrizorSDK Example",
                      ),
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController cpfController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: cpfController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'CPF',
                ),
              ),
            ),
            Container(height: 20),
            ElevatedButton(
              child: const Text("Open PrizorSDK"),
              onPressed: () async {
                if (cpfController.text != "" && cpfController.text.length == 11) {
                  await Permission.location.request();
                  await Permission.camera.request();
                  await Permission.microphone.request();

                  if (mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => PrizorSdkPage(
                          cpf: cpfController.text.replaceAll(RegExp("[\\D]"), ""),
                        ),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('SDK Initialization error.'),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyRootHomePage extends StatefulWidget {
  const MyRootHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyRootHomePage> createState() => _MyRootHomePageState();
}

class _MyRootHomePageState extends State<MyRootHomePage> {
  final String DOCUMENT_FAKER = "40583583946";

  late final List<Widget> _children = [
    const MyHomePage(title: "HOME"),
    PrizorSdkPage(
      cpf: DOCUMENT_FAKER,
      isRootRoute: true,
      titleRoute: 'Benefícios',
    ),
  ];

  int _currentIndex = 0;

  void _setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          _setIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_shortcut_outlined),
            label: "PrizorSDK",
          ),
        ],
      ),
    );
  }
}

class PrizorSdkPage extends StatefulWidget {
  const PrizorSdkPage({
    super.key,
    required this.cpf,
    this.isRootRoute = false,
    this.titleRoute = "",
  });

  final String cpf;
  final String titleRoute;
  final bool isRootRoute;

  @override
  State<PrizorSdkPage> createState() => _PrizorSdkPageState();
}

class _PrizorSdkPageState extends State<PrizorSdkPage> {
  @override
  Widget build(BuildContext context) {
    return PrizorSdkWidget(
      androidAPIErrorCallback: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Android Version Error.")),
      ),
      params: PrizorSdkParams(
        platform: 'android',
        environment: Environment.stage,
        appId: "5787892290000",
        secret: "68a96828a395f4f993ffbb54dfa2cd443f3f0793",
        appName: "PrizorSDK Example",
        isRootRoute: widget.isRootRoute,
        titleRoute: widget.titleRoute,
        accentColor: const Color(0xFFFFDF6B),
        accentForegroundColor: Colors.white,
        user: const User(
          name: "Paulo Koga",
          documentNumber: "23891368003",
          otherDocument: '107688921',
          cellphone: "+5519981726819",
          day: 29,
          month: 4,
          year: 1990,
          gender: Gender.male,
          addresses: [
            Address(
              zipCode: '05402-600',
              country: "Brasil",
              state: "SP",
              stateName: "São Paulo",
              city: "São Paulo",
              neighborhood: "Pinheiros",
              address: 'Av. Rebouças',
              number: '3970',
            ),
          ],
        ),
      ),
    );
  }
}
