import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Kontak',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DaftarKontakPage(),
    );
  }
}

class DaftarKontakPage extends StatefulWidget {
  @override
  _DaftarKontakPageState createState() => _DaftarKontakPageState();
}

class _DaftarKontakPageState extends State<DaftarKontakPage> {
  final List<Map<String, String>> _kontakList = [];
  final _formKey = GlobalKey<FormState>();
  String? _nama;
  String? _nomorTelepon;

  // Fungsi untuk menambah kontak
  void _tambahKontak() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _kontakList.add({'nama': _nama!, 'nomor': _nomorTelepon!});
      });
      Navigator.of(context).pop();
    }
  }

  // Form untuk menambah kontak
  void _showTambahKontakForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Kontak'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nama :'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nama = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nomor Telepon :'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon tidak boleh kosong';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nomorTelepon = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: _tambahKontak,
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menghapus kontak
  void _hapusKontak(int index) {
    setState(() {
      _kontakList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kontak'),
      ),
      body: _kontakList.isEmpty
          ? Center(
              child: Text('Belum ada kontak'),
            )
          : ListView.builder(
              itemCount: _kontakList.length,
              itemBuilder: (context, index) {
                final kontak = _kontakList[index];
                return ListTile(
                  title: Text(kontak['nama']!),
                  subtitle: Text(kontak['nomor']!),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _hapusKontak(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTambahKontakForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
