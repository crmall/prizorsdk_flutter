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
      home: MyHomePage(title: title),
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

                  if (context.mounted) {
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

class PrizorSdkPage extends StatefulWidget {
  const PrizorSdkPage({required this.cpf, super.key});

  final String cpf;

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
        environment: Environment.production,
        appId: "***",
        secret: "***",
        appName: "Test SDK",
        appLogo: null,
        appBrand: null,
        accentColor: const Color(0xFFF1BF3B),
        accentForegroundColor: const Color(0xFFFFFFFF),
        splashBackgroundColor: null,
        splashForegroundColor: null,
        user: User(
          documentNumber: widget.cpf,
          cellphone: "+5512345678901",
          name: "João da Silva",
          otherDocument: "123456789",
          gender: Gender.male,
          maritalStatus: MaritalStatus.single,
          day: 1,
          month: 1,
          year: 1990,
          occupation: "Programador",
          phones: [
            const Phone(
              phoneNumber: "+5544991720532",
              isOptIn: true,
            ),
          ],
          emails: [
            const Email(
              email: "krayony@gmail.com",
              isOptIn: true,
            ),
          ],
          addresses: [
            const Address(
              zipCode: 84035902,
              country: "Brasil",
              state: "PR",
              stateName: "Paraná",
              city: "Maringá",
              neighborhood: "Centro",
              address: "Avenida Tamandaré",
              number: "100",
              isOptIn: true,
            ),
          ],
        ),
        sac: const Sac(
          title: "Precisa de ajuda?",
          content: "Segunda a sábado: 10h às 22h\nDomingos e Feriados: 14h às 20h",
          email: "sac@prizor.com",
          phone1: "+554432186300",
          phone1Caption: "(44) 3218-6300",
          phone2: "https://api.whatsapp.com/send?phone=5544987654321",
          phone2Caption: "(44) 98765-4321",
        ),
      ),
    );
  }
}
