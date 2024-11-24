import 'package:flutter/material.dart';

class PostJobPage extends StatefulWidget {
  const PostJobPage({Key? key}) : super(key: key);

  @override
  State<PostJobPage> createState() => _PostJobPageState();
}

class _PostJobPageState extends State<PostJobPage> {
  final _formKey = GlobalKey<FormState>();

  // Dropdown values
  String? selectedDistrict;
  String? selectedTown;
  List<String> towns = [];

  // Districts and corresponding towns
  final Map<String, List<String>> keralaTowns = {
    'Thiruvananthapuram': ['Kazhakoottam', 'Neyyattinkara', 'Varkala'],
    'Kollam': ['Kottarakkara', 'Punalur', 'Paravur'],
    'Pathanamthitta': ['Adoor', 'Pandalam', 'Thiruvalla'],
    'Alappuzha': ['Cherthala', 'Kayamkulam', 'Haripad'],
    'Kottayam': ['Changanassery', 'Pala', 'Ettumanoor'],
    'Idukki': ['Thodupuzha', 'Munnar', 'Nedumkandam'],
    'Ernakulam': ['Kochi', 'Aluva', 'Perumbavoor'],
    'Thrissur': ['Guruvayur', 'Chalakudy', 'Irinjalakuda'],
    'Palakkad': ['Shoranur', 'Mannarkkad', 'Ottappalam'],
    'Malappuram': ['Manjeri', 'Perinthalmanna', 'Tirur'],
    'Kozhikode': ['Vadakara', 'Koyilandy', 'Balussery'],
    'Wayanad': ['Kalpetta', 'Sulthan Bathery', 'Mananthavady'],
    'Kannur': ['Taliparamba', 'Payyanur', 'Mattannur'],
    'Kasaragod': ['Kanhangad', 'Uppala', 'Bekal'],
  };

  // Form field controllers
  final TextEditingController propertyTypeController = TextEditingController();
  final TextEditingController jobTypeController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController plotSizeController = TextEditingController();
  final TextEditingController roomsController = TextEditingController();
  final TextEditingController floorsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Job',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: const Text(
            'Post Job',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Times New Roman',
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildCard('Property Details', [
                    _buildTextField('Property Type', 'Enter property type (e.g., Residential)', propertyTypeController),
                    _buildTextField('Job Type', 'Enter job type (e.g., Painting)', jobTypeController),
                  ]),
                  const SizedBox(height: 16),
                  _buildCard('Location Details', [
                    _buildDropdownField('District', 'Select District', keralaTowns.keys.toList(), (value) {
                      setState(() {
                        selectedDistrict = value;
                        towns = keralaTowns[value!]!;
                        selectedTown = null;
                      });
                    }, selectedDistrict),
                    _buildDropdownField('Town', 'Select Town', towns, (value) {
                      setState(() {
                        selectedTown = value;
                      });
                    }, selectedTown),
                    _buildTextField('Landmark', 'Enter nearby landmark (optional)', landmarkController, required: false),
                    _buildTextField('Property Address', 'Enter property address', addressController),
                  ]),
                  const SizedBox(height: 16),
                  _buildCard('Contact Details', [
                    _buildTextField('Contact Number', 'Enter contact number', contactController, inputType: TextInputType.phone),
                  ]),
                  const SizedBox(height: 16),
                  _buildCard('Property Description', [
                    _buildTextField('Plot Size (sq ft)', 'Enter plot size in square feet', plotSizeController, inputType: TextInputType.number),
                    _buildTextField('Number of Rooms', 'Enter total number of rooms', roomsController, inputType: TextInputType.number),
                    _buildTextField('Number of Floors', 'Enter total number of floors', floorsController, inputType: TextInputType.number),
                  ]),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      backgroundColor: Colors.green[700],
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Job Posted Successfully!')),
                        );
                      }
                    },
                    child: const Text(
                      'Post Job',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller,
      {TextInputType inputType = TextInputType.text, bool required = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.green),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.green, width: 2.0),
          ),
        ),
        validator: (value) {
          if (required && (value == null || value.isEmpty)) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(String label, String hint, List<String> items, void Function(String?) onChanged, String? selectedValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: hint,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.green),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.green, width: 2.0),
          ),
        ),
        value: selectedValue,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }
}
