import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gender_picker/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:hotel_san_miguel/screens/navigation_drawer.dart';

import 'package:hotel_san_miguel/widgets/button_datepicker.dart';
import 'package:hotel_san_miguel/widgets/space_interline_xs.dart';

final items = <String>[
  'Estado Civil',
  'Soltero',
  'Casado',
  'Divorciado',
  'Viudo',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKeyCreate = GlobalKey<FormState>();
  final _formKeyUpdate = GlobalKey<FormState>();

  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dniNumberController = TextEditingController();
  // final TextEditingController _sexController = TextEditingController();
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
  final TextEditingController _searchController = TextEditingController();

  Timestamp _checkIn = Timestamp.now();
  Timestamp _checkOut = Timestamp.now();

  String? _valueDrop = items.first;

  Gender? _genderSelected = Gender.Male;

  final CollectionReference _customer =
      FirebaseFirestore.instance.collection('customer');

  //Method creation (create)
  void _create([DocumentSnapshot? documentSnapshot]) {
    if (documentSnapshot != null) {
      _namesController.text = documentSnapshot['names'];
      _lastNameController.text = documentSnapshot['lastName'];
      _dniNumberController.text = documentSnapshot['dniNumber'].toString();
      _asignarGender(documentSnapshot['sex']);
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

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return SizedBox(
            height: 720.0,
            child: StatefulBuilder(
              builder: (context, setEstado) {
                return Form(
                  key: _formKeyCreate,
                  child: Padding(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '  Salida  ',
                                style: TextStyle(
                                  color: Colors.black54,
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
                          _genderwidget(true, false),
                          const SpaceInterlineXs(),
                          SizedBox(
                            width: 250.0,
                            child: _searchcustomer(),
                          ),
                          const SpaceInterlineXs(),
                          _field(_namesController, label: 'Nombres'),
                          const SpaceInterlineXs(),
                          _field(_lastNameController, label: 'Apellidos'),
                          const SpaceInterlineXs(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 170.0,
                                child: _field(_dniNumberController,
                                    label: 'Dni N°'),
                              ),
                              SizedBox(
                                width: 170.0,
                                child: _maritalStatuswidget(setEstado),
                              ),
                            ],
                          ),
                          const SpaceInterlineXs(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 170.0,
                                height: 60.0,
                                child: _field(_ageController, label: 'Edad'),
                              ),
                              SizedBox(
                                width: 170.0,
                                height: 60.0,
                                child: _field(_roomNumberController,
                                    label: 'Habitación N°'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          _field(_occupationController, label: 'Ocupación'),
                          const SpaceInterlineXs(),
                          _field(_originController, label: 'Procedencia'),
                          const SpaceInterlineXs(),
                          _field(_destinyController, label: 'Destino'),
                          const SpaceInterlineXs(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 170.0,
                                height: 60.0,
                                child: _field(_adultsNumberController,
                                    label: 'Adultos N°'),
                              ),
                              SizedBox(
                                width: 170.0,
                                height: 60.0,
                                child: _field(_childrenNumberController,
                                    label: 'Niños N°'),
                              ),
                            ],
                          ),
                          const SpaceInterlineXs(),
                          ElevatedButton(
                            child: const Text('Crear'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            onPressed: () async {
                              if (!_formKeyCreate.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Complete los campos')),
                                );

                                return;
                              }

                              final String names = _namesController.text;
                              final String lastName = _lastNameController.text;
                              final String dniNumber =
                                  _dniNumberController.text;
                              final String sex = _getGenderDB();
                              final String age = _ageController.text;
                              final String maritalStatus =
                                  _maritalStatusController.text;
                              final String occupation =
                                  _occupationController.text;
                              final String origin = _originController.text;
                              final String destiny = _destinyController.text;
                              final String roomNumber =
                                  _roomNumberController.text;
                              final String adultsNumber =
                                  _adultsNumberController.text;
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

                              _limpiarTextos();

                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Se ha creado el cliente $names $lastName.")));
                                Navigator.pop(context);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  //Method creation (update)
  void _update([DocumentSnapshot? documentSnapshot]) {
    if (documentSnapshot != null) {
      _namesController.text = documentSnapshot['names'];
      _lastNameController.text = documentSnapshot['lastName'];
      _dniNumberController.text = documentSnapshot['dniNumber'].toString();
      _asignarGender(documentSnapshot['sex']);
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
      _checkIn = documentSnapshot['checkIn'];
      _checkOut = documentSnapshot['checkOut'];
    }

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return SizedBox(
            height: 720.0,
            child: StatefulBuilder(builder: (context, setEstado) {
              return Form(
                key: _formKeyUpdate,
                child: Padding(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            DatetimePickerWidget(
                              (p0) {
                                debugPrint('$p0');

                                final d = p0.toDate();

                                debugPrint('${d.day}/${d.month}/${d.year}');
                                debugPrint('${d.hour}:${d.minute}');

                                setState(() {
                                  _checkIn = p0;
                                });
                              },
                              selectedTime: _checkIn,
                            ),
                            DatetimePickerWidget(
                              (p0) {
                                debugPrint('$p0');

                                final d = p0.toDate();

                                debugPrint('${d.day}/${d.month}/${d.year}');
                                debugPrint('${d.hour}:${d.minute}');

                                setState(() {
                                  _checkOut = p0;
                                });
                              },
                              selectedTime: _checkOut,
                            ),
                          ],
                        ),
                        _genderwidget(true, false),
                        const SpaceInterlineXs(),
                        _field(_namesController, label: 'Nombres'),
                        const SpaceInterlineXs(),
                        _field(_lastNameController, label: 'Apellidos'),
                        const SpaceInterlineXs(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 170.0,
                              child:
                                  _field(_dniNumberController, label: 'Dni N°'),
                            ),
                            SizedBox(
                              width: 170.0,
                              child: _maritalStatuswidget(setEstado),
                            ),
                          ],
                        ),
                        const SpaceInterlineXs(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 170.0,
                              height: 60.0,
                              child: _field(_ageController, label: 'Edad'),
                            ),
                            SizedBox(
                              width: 170.0,
                              height: 60.0,
                              child: _field(_roomNumberController,
                                  label: 'Habitación N°'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        _field(_occupationController, label: 'Ocupación'),
                        const SpaceInterlineXs(),
                        _field(_originController, label: 'Procedencia'),
                        const SpaceInterlineXs(),
                        _field(_destinyController, label: 'Destino'),
                        const SpaceInterlineXs(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 170.0,
                              height: 60.0,
                              child: _field(_adultsNumberController,
                                  label: 'Adultos N°'),
                            ),
                            SizedBox(
                              width: 170.0,
                              height: 60.0,
                              child: _field(_childrenNumberController,
                                  label: 'Niños N°'),
                            ),
                          ],
                        ),
                        const SpaceInterlineXs(),
                        ElevatedButton(
                          child: const Text('Actualizar'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () async {
                            if (!_formKeyUpdate.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Complete los campos')),
                              );

                              return;
                            }

                            final String names = _namesController.text;
                            final String lastName = _lastNameController.text;
                            final String dniNumber = _dniNumberController.text;
                            final String sex = _getGenderDB();
                            final String age = _ageController.text;
                            final String maritalStatus =
                                _maritalStatusController.text;
                            final String occupation =
                                _occupationController.text;
                            final String origin = _originController.text;
                            final String destiny = _destinyController.text;
                            final String roomNumber =
                                _roomNumberController.text;
                            final String adultsNumber =
                                _adultsNumberController.text;
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
                              "checkIn": _checkIn,
                              "checkOut": _checkOut,
                            });

                            _limpiarTextos();

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Se ha actualizado el cliente $names $lastName.")));
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        });
  }

  //Method creation (delete)
  Future<void> _delete(String customerId) async {
    await _customer.doc(customerId).delete();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Eliminado satisfactoriamente')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel San Miguel'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.indigo,
                Colors.red,
              ],
            ),
          ),
        ),
      ),
      drawer: const NavigationDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _limpiarTextos();
          _create();
        },
        child: const Icon(Icons.person_add),
        backgroundColor: Colors.red,
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
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(
                      documentSnapshot['names'] +
                          ' ' +
                          documentSnapshot['lastName'],
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    subtitle: Text(documentSnapshot['dniNumber'].toString()),
                    trailing: SizedBox(
                      width: 98.0,
                      child: Row(
                        children: [
                          IconButton(
                              splashRadius: 20,
                              icon: const Icon(Icons.edit),
                              color: Colors.indigo,
                              onPressed: () => _showDialog(
                                    context,
                                    description: '¿Esta seguro de actualizar?',
                                    action: () => _update(documentSnapshot),
                                  )),
                          // Press this button to delete a single customer
                          IconButton(
                            splashRadius: 20,
                            icon: const Icon(Icons.delete),
                            color: Colors.indigo,
                            onPressed: () => _showDialog(
                              context,
                              description: '¿Esta seguro de eliminar?',
                              action: () => _delete(documentSnapshot.id),
                            ),
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

  Widget _field(
    TextEditingController controller, {
    required String label,
    TextInputType? keyboardType,
    String? textValidator,
  }) {
    return TextFormField(
      autofocus: false,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(_icon(label)),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: _hintText(label),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return textValidator ?? 'Por favor, introduzca un texto';
        }
        return null;
      },
    );
  }

  String _getGenderDB() {
    if (_genderSelected == Gender.Male) {
      return 'Masculino';
    } else if (_genderSelected == Gender.Female) {
      return 'Femenino';
    } else {
      return 'Otro';
    }
  }

  void _asignarGender(String g) {
    if (g == 'Masculino') {
      _genderSelected = Gender.Male;
    } else if (g == 'Femenino') {
      _genderSelected = Gender.Female;
    } else {
      _genderSelected = Gender.Others;
    }
  }

  Widget _genderwidget(bool _showOther, bool _alignment) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        showOtherGender: _showOther,
        verticalAlignedText: _alignment,
        onChanged: (value) {
          setState(() {
            _genderSelected = value;
          });
        },
        selectedGender: _genderSelected,
        maleText: 'Masculino',
        femaleText: 'Femenino',
        otherGenderText: 'Otro',
        linearGradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo,
              Colors.red,
            ]),
        selectedGenderTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        unSelectedGenderTextStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
        equallyAligned: true,
        size: 40,
        animationDuration: const Duration(seconds: 1),
        isCircular: true,
        opacityOfGradient: 0.5,
      ),
    );
  }

  Widget _searchcustomer() {
    return TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      controller: _searchController,
      decoration: InputDecoration(
        prefixIcon: IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.search),
            onPressed: () {
              _searchdni();
            }),
        suffixIcon: IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
          },
        ),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Buscar por Dni',
        labelText: 'Buscar',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget _searchdni() {
    return StreamBuilder(
      stream: _customer.snapshots(), //build connection
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length, //numbers of rows
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              if (documentSnapshot['dniNumber'] == _searchController.text) {
                return _namesController.text = documentSnapshot['names'];
              }
              return Container();
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _maritalStatuswidget(void Function(void Function()) setEstado) {
    debugPrint("_valueDrop = $_valueDrop");

    return Container(
      width: 150.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _valueDrop,
          isExpanded: false,
          elevation: 16,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
          onChanged: (String? newValue) {
            _valueDrop = newValue;
            setEstado(() {});
            debugPrint('new value -> _valueDrop: $_valueDrop');
          },
          items: items.map(buildDrop).toList(),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildDrop(String item) {
    return DropdownMenuItem<String>(
      child: Text(item),
      value: item,
    );
  }

  void _showDialog(
    BuildContext context, {
    String? description,
    required void Function() action,
  }) async {
    final respuesta = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmacion'),
        content: Text(description ?? '¿Esta seguro?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (mounted) {
                Navigator.pop(context, false);
              }
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              if (mounted) {
                Navigator.pop(context, true);
              }
            },
            child: const Text('Si'),
          ),
        ],
      ),
    );

    if (respuesta == true) {
      action();
    }
  }

  void _limpiarTextos() {
    _namesController.text = '';
    _lastNameController.text = '';
    _dniNumberController.text = '';
    _genderSelected = Gender.Male;
    _ageController.text = '';
    _maritalStatusController.text = '';
    _occupationController.text = '';
    _originController.text = '';
    _destinyController.text = '';
    _roomNumberController.text = '';
    _adultsNumberController.text = '';
    _childrenNumberController.text = '';
    _searchController.text = '';
  }
}

String _hintText(label) {
  if (label == 'Nombres') {
    return 'Nombres';
  } else if (label == 'Apellidos') {
    return 'Apellidos';
  } else if (label == 'Dni N°') {
    return '00000000';
  } else if (label == 'Edad') {
    return '00';
  } else if (label == 'Ocupación') {
    return 'Ocupación o profesión';
  } else if (label == 'Procedencia') {
    return 'Lugar de procedencia';
  } else if (label == 'Destino') {
    return 'Lugar de destino';
  } else if (label == 'Habitación N°') {
    return '000';
  } else if (label == 'Adultos N°') {
    return '00';
  } else if (label == 'Niños N°') {
    return '00';
  } else {
    return 'Por favor, introduzca un texto';
  }
}

IconData _icon(String label) {
  if (label == 'Nombres') {
    return Icons.person;
  } else if (label == 'Apellidos') {
    return Icons.person;
  } else if (label == 'Dni N°') {
    return Icons.badge;
  } else if (label == 'Edad') {
    return Icons.escalator_warning;
  } else if (label == 'Ocupación') {
    return Icons.engineering;
  } else if (label == 'Procedencia') {
    return Icons.luggage;
  } else if (label == 'Destino') {
    return Icons.airplane_ticket;
  } else if (label == 'Habitación N°') {
    return Icons.hotel_rounded;
  } else if (label == 'Adultos N°') {
    return Icons.man;
  } else if (label == 'Niños N°') {
    return Icons.boy;
  } else {
    return Icons.person;
  }
}
