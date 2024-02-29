import 'package:drivers_app_project/global/global.dart';
import 'package:drivers_app_project/splash_screen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {

  TextEditingController carModelEditingController = TextEditingController();
  TextEditingController carNumberEditingController = TextEditingController();
  TextEditingController carColorEditingController = TextEditingController();
  
  List<String> carTypesList = ['uber-x', 'uber-go', 'moto'];
  String? selectedCarType;

  saveCarInfo() async{
    //A função cria um mapa chamado driverCarInfoMap,
    // onde são armazenadas as informações do carro, como cor, número e modelo do carro, bem como o tipo de carro selecionado.
    Map driverCarInfoMap = {
      'car_color': carColorEditingController.text.trim(),
      'car_number': carNumberEditingController.text.trim(),
      'car_model': carModelEditingController.text.trim(),
      'type': selectedCarType,
    };
    //Em seguida, é obtida uma referência para o banco de dados do Firebase usando FirebaseDatabase.instance.ref()

    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child('drivers');

    //Em seguida, o mapa driverCarInfoMap é salvo como um filho (child) do nó 'drivers' com o ID do usuário atualmente logado (currentFirebaseUser!.uid).
    // Essas informações do carro são armazenadas no nó 'car_details' dentro do nó do motorista.
    driversRef.child(currentFirebaseUser!.uid).child('car_details').set(driverCarInfoMap);

    //Após salvar as informações do carro com sucesso, uma mensagem de sucesso é exibida usando Fluttertoast.showToast().
    // Em seguida, a tela MySplashScreen é navegada usando Navigator.push().

    Fluttertoast.showToast(msg: 'Detalhes do carro salvos com sucesso!');
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MySplashScreen()));

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('images/logo1.png'),
              ),
              const SizedBox(height: 10,),

              const Text('Informações do Carro', style: TextStyle(fontSize: 22, color: Colors.grey, fontWeight: FontWeight.bold),),

              TextField(
                controller: carModelEditingController,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                    labelText: 'Modelo do Carro',
                    hintText: 'Modelo do Carro',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                    ),
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                    )
                ),
              ),
              TextField(
                controller: carNumberEditingController,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                    labelText: 'Placa do Carro',
                    hintText: 'Placa do Carro',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                    ),
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                    )
                ),
              ),
              TextField(
                controller: carColorEditingController,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                    labelText: 'Cor do Carro',
                    hintText: 'Cor do Carro',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                    ),
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                    )
                ),
              ),

              const SizedBox(height: 10,),

              Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton(
                  iconSize: 40,
                  dropdownColor: Colors.black87, // muda a cor do menu
                  hint: const Text('Por favor, Selecione o Tipo do Carro:', style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  value: selectedCarType,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCarType = newValue.toString();
                    });
                },
                  items: carTypesList.map((car) {
                    return DropdownMenuItem(child: Text(car, style: TextStyle(color: Colors.grey,),), value: car,);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20,),

              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: (){
                   if(carColorEditingController.text.isNotEmpty
                       && carNumberEditingController.text.isNotEmpty
                       && carModelEditingController.text.isNotEmpty && selectedCarType != null){
                     
                     saveCarInfo();
                   }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent
                  ),
                  child: const Text('Salvar', style: TextStyle(color: Colors.black54, fontSize: 16),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
