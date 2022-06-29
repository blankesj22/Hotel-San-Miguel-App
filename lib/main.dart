import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_san_miguel/widgets/button_datepicker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel San Miguel',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dniNumberController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinyController = TextEditingController();
  final TextEditingController _roomNumberController = TextEditingController();
  final TextEditingController _adultsNumberController = TextEditingController();
  final TextEditingController _childrenNumberController =
      TextEditingController();

  Timestamp _checkIn = Timestamp.now();
  Timestamp _checkOut = Timestamp.now();

  final CollectionReference _customer =
      FirebaseFirestore.instance.collection('customer');

  //Method creation (create, update and delete)
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _namesController.text = documentSnapshot['names'];
      _lastNameController.text = documentSnapshot['lastName'];
      _dniNumberController.text = documentSnapshot['dniNumber'].toString();
      _sexController.text = documentSnapshot['sex'];
      _ageController.text = documentSnapshot['age'].toString();
      _maritalStatusController.text = documentSnapshot['maritalStatus'];
      _occupationController.text = documentSnapshot['occupation'];
      _originController.text = documentSnapshot['origin'];
      _destinyController.text = documentSnapshot['destiny'].toString();
      _roomNumberController.text = documentSnapshot['roomNumber'].toString();
      _adultsNumberController.text =
          documentSnapshot['adultsNumber'].toString();
      _childrenNumberController.text =
          documentSnapshot['childrenNumber'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              //prevent the soft keyboard from covering text fields
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        'Registrar Cliente',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Ingreso  ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '  Salida  ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DatetimePickerWidget((p0) {
                        debugPrint('$p0');

                        final d = p0.toDate();

                        debugPrint('${d.day}/${d.month}/${d.year}');
                        debugPrint('${d.hour}:${d.minute}');

                        setState(() {
                          _checkIn = p0;
                        });
                      }),
                      DatetimePickerWidget((p0) {
                        debugPrint('$p0');

                        final d = p0.toDate();

                        debugPrint('${d.day}/${d.month}/${d.year}');
                        debugPrint('${d.hour}:${d.minute}');

                        setState(() {
                          _checkOut = p0;
                        });
                      }),
                    ],
                  ),
                  TextField(
                    controller: _namesController,
                    decoration: const InputDecoration(labelText: 'Nombres'),
                  ),
                  TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Apellidos'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150.0,
                        height: 60.0,
                        child: TextField(
                          controller: _dniNumberController,
                          decoration:
                              const InputDecoration(labelText: 'Dni N°'),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 60.0,
                        child: TextField(
                          controller: _maritalStatusController,
                          decoration:
                              const InputDecoration(labelText: 'Estado Civil'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150.0,
                        height: 60.0,
                        child: TextField(
                          controller: _sexController,
                          decoration: const InputDecoration(labelText: 'Sexo'),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 60.0,
                        child: TextField(
                          controller: _ageController,
                          decoration: const InputDecoration(labelText: 'Edad'),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _occupationController,
                    decoration: const InputDecoration(labelText: 'Ocupación'),
                  ),
                  TextField(
                    controller: _originController,
                    decoration: const InputDecoration(labelText: 'Procedencia'),
                  ),
                  TextField(
                    controller: _destinyController,
                    decoration: const InputDecoration(labelText: 'Destino'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100.0,
                        height: 60.0,
                        child: TextField(
                          controller: _roomNumberController,
                          decoration:
                              const InputDecoration(labelText: 'Habitación N°'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150.0,
                        height: 60.0,
                        child: TextField(
                          controller: _adultsNumberController,
                          decoration:
                              const InputDecoration(labelText: 'Adultos N°'),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 60.0,
                        child: TextField(
                          controller: _childrenNumberController,
                          decoration:
                              const InputDecoration(labelText: 'Niños N°'),
                        ),
                      ),
                    ],
                  ),

                  // check out with date picker of selection date and time
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Crear'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                    ),
                    onPressed: () async {
                      final String names = _namesController.text;
                      final String lastName = _lastNameController.text;
                      final String dniNumber = _dniNumberController.text;
                      final String sex = _sexController.text;
                      final String age = _ageController.text;
                      final String maritalStatus =
                          _maritalStatusController.text;
                      final String occupation = _occupationController.text;
                      final String origin = _originController.text;
                      final String destiny = _destinyController.text;
                      final String roomNumber = _roomNumberController.text;
                      final String adultsNumber = _adultsNumberController.text;
                      final String childrenNumber =
                          _childrenNumberController.text;

                      await _customer.add({
                        "checkIn": _checkIn,
                        "names": names,
                        "lastName": lastName,
                        "dniNumber": dniNumber,
                        "sex": sex,
                        "age": age,
                        "maritalStatus": maritalStatus,
                        "occupation": occupation,
                        "origin": origin,
                        "destiny": destiny,
                        "roomNumber": roomNumber,
                        "adultsNumber": adultsNumber,
                        "childrenNumber": childrenNumber,
                        "checkOut": _checkOut,
                      });

                      _namesController.text = '';
                      _lastNameController.text = '';
                      _dniNumberController.text = '';
                      _sexController.text = '';
                      _ageController.text = '';
                      _maritalStatusController.text = '';
                      _occupationController.text = '';
                      _originController.text = '';
                      _destinyController.text = '';
                      _roomNumberController.text = '';
                      _adultsNumberController.text = '';
                      _childrenNumberController.text = '';
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _namesController.text = documentSnapshot['names'];
      _lastNameController.text = documentSnapshot['lastName'];
      _dniNumberController.text = documentSnapshot['dniNumber'].toString();
      _sexController.text = documentSnapshot['sex'];
      _ageController.text = documentSnapshot['age'].toString();
      _maritalStatusController.text = documentSnapshot['maritalStatus'];
      _occupationController.text = documentSnapshot['occupation'];
      _originController.text = documentSnapshot['origin'];
      _destinyController.text = documentSnapshot['destiny'];
      _roomNumberController.text = documentSnapshot['roomNumber'].toString();
      _adultsNumberController.text =
          documentSnapshot['adultsNumber'].toString();
      _childrenNumberController.text =
          documentSnapshot['childrenNumber'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              //prevent the soft keyboard from covering text fields
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        'Editar Cliente',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Ingreso  ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '  Salida  ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DatetimePickerWidget((p0) {
                        debugPrint('$p0');

                        final d = p0.toDate();

                        debugPrint('${d.day}/${d.month}/${d.year}');
                        debugPrint('${d.hour}:${d.minute}');

                        setState(() {
                          _checkIn = p0;
                        });
                      }),
                      DatetimePickerWidget((p0) {
                        debugPrint('$p0');

                        final d = p0.toDate();

                        debugPrint('${d.day}/${d.month}/${d.year}');
                        debugPrint('${d.hour}:${d.minute}');

                        setState(() {
                          _checkOut = p0;
                        });
                      }),
                    ],
                  ),
                  TextField(
                    controller: _namesController,
                    decoration: const InputDecoration(labelText: 'Nombres'),
                  ),
                  TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Apellidos'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150.0,
                        height: 60.0,
                        child: TextField(
                          controller: _dniNumberController,
                          decoration:
                              const InputDecoration(labelText: 'Dni N°'),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 60.0,
                        child: TextField(
                          controller: _maritalStatusController,
                          decoration:
                              const InputDecoration(labelText: 'Estado Civil'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150.0,
                        height: 60.0,
                        child: TextField(
                          controller: _sexController,
                          decoration: const InputDecoration(labelText: 'Sexo'),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 60.0,
                        child: TextField(
                          controller: _ageController,
                          decoration: const InputDecoration(labelText: 'Edad'),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _occupationController,
                    decoration: const InputDecoration(labelText: 'Ocupación'),
                  ),
                  TextField(
                    controller: _originController,
                    decoration: const InputDecoration(labelText: 'Procedencia'),
                  ),
                  TextField(
                    controller: _destinyController,
                    decoration: const InputDecoration(labelText: 'Destino'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100.0,
                        height: 60.0,
                        child: TextField(
                          controller: _roomNumberController,
                          decoration:
                              const InputDecoration(labelText: 'Habitación N°'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150.0,
                        height: 60.0,
                        child: TextField(
                          controller: _adultsNumberController,
                          decoration:
                              const InputDecoration(labelText: 'Adultos N°'),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 60.0,
                        child: TextField(
                          controller: _childrenNumberController,
                          decoration:
                              const InputDecoration(labelText: 'Niños N°'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Actualizar'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                    ),
                    onPressed: () async {
                      final String names = _namesController.text;
                      final String lastName = _lastNameController.text;
                      final String dniNumber = _dniNumberController.text;
                      final String sex = _sexController.text;
                      final String age = _ageController.text;
                      final String maritalStatus =
                          _maritalStatusController.text;
                      final String occupation = _occupationController.text;
                      final String origin = _originController.text;
                      final String destiny = _destinyController.text;
                      final String roomNumber = _roomNumberController.text;
                      final String adultsNumber = _adultsNumberController.text;
                      final String childrenNumber =
                          _childrenNumberController.text;

                      await _customer.doc(documentSnapshot!.id).update({
                        "names": names,
                        "lastName": lastName,
                        "dniNumber": dniNumber,
                        "sex": sex,
                        "age": age,
                        "maritalStatus": maritalStatus,
                        "occupation": occupation,
                        "origin": origin,
                        "destiny": destiny,
                        "roomNumber": roomNumber,
                        "adultsNumber": adultsNumber,
                        "childrenNumber": childrenNumber,
                      });
                      _namesController.text = '';
                      _lastNameController.text = '';
                      _dniNumberController.text = '';
                      _sexController.text = '';
                      _ageController.text = '';
                      _maritalStatusController.text = '';
                      _occupationController.text = '';
                      _originController.text = '';
                      _destinyController.text = '';
                      _roomNumberController.text = '';
                      _adultsNumberController.text = '';
                      _childrenNumberController.text = '';
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _delete(String customerId) async {
    await _customer.doc(customerId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Eliminado satisfactoriamente')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel San Miguel'),
        backgroundColor: Colors.blue.shade900,
        actions: <Widget>[
          IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Reportes',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Reportes'),
                      backgroundColor: Colors.blue.shade900,
                    ),
                    body: const Center(
                      child: Text(
                        'This is the next page',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.person_add),
        backgroundColor: Colors.blue.shade900,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: _customer.snapshots(), //build connection
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length, //numbers of rows
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['names'] +
                        ' ' +
                        documentSnapshot['lastName']),
                    subtitle: Text(documentSnapshot['dniNumber'].toString()),
                    trailing: SizedBox(
                      width: 98.0,
                      child: Row(
                        children: [
                          IconButton(
                              splashRadius: 20,
                              icon: const Icon(Icons.edit),
                              color: Colors.blue.shade900,
                              onPressed: () => _update(documentSnapshot)),
                          // Press this button to delete a single customer
                          IconButton(
                            splashRadius: 20,
                            icon: const Icon(Icons.delete),
                            color: Colors.blue.shade900,
                            onPressed: () => _delete(documentSnapshot.id),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
