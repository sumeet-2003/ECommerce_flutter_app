import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _problemController = TextEditingController();
  String? _selectedProblem;
  String? _customProblem;
  String _estimatedCost = '';

  final Map<String, String> _problemCosts = {
    'House Wiring': '16 Rs/sq ft',
    'Fan Fitting': '150 Rs',
    'Tubelight Fitting': '100 Rs',
    'MCB Fitting': '150 Rs',
    'Forepole Fitting': '600 Rs',
    'Switch Board': '100 Rs/board',
    'Open Fitting': '13 Rs/sq ft',
    'Gidger Fitting': '700 Rs',
    'Wall Fan Fitting': '',
    'Meter Board Fitting': '500 Rs',
    'Service Cable': '14 Rs/sq ft',
    'House Wirring': '16 Rs/sq ft',
    'Complex Wirring': '15 Rs/sq ft',
    'Fall Celling Reparing': '30 Rs/sq ft',
    'Rope Light': '',
    'Tullu Pump': '200 Rs',
    'Bore Panal': '300 Rs',
    'Coller Fitting': '350 Rs',
    'Exost': '200 Rs',
    'Gatelight Fitting': '600 Rs',
    'Other': '',
  };
  final List<String> _problems = [
    'House Wiring',
    'Fan Fitting',
    'Tubelight Fitting',
    'MCB Fitting',
    'Forepole Fitting',
    'Switch Board',
    'Open Fitting',
    'Gidger Fitting',
    'Wall Fan Fitting',
    'Meter Board Fitting',
    'Service Cable',
    'House Wirring',
    'Complex Wirring',
    'Fall Celling Reparing',
    'Rope Light',
    'Tullu Pump',
    'Bore Panal',
    'Coller Fitting',
    'Exost',
    'Gatelight Fitting',
    'Other'
  ];

  void _updateEstimatedCost(String problem) {
    setState(() {
      _estimatedCost = _problemCosts[problem] ?? '';
    });
  }

  void _launchWhatsApp() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final phone = _phoneController.text;
      final address = _addressController.text;
      final problem = _selectedProblem == 'Other' ? _customProblem : _selectedProblem;
      const msg = "*Repair Request*";
      final message = '$msg\nName: $name\nPhone: $phone\nAddress: $address\nProblem: $problem\nEstimated Cost: $_estimatedCost';

      final Uri url = Uri.parse('https://wa.me/919770497756?text=${Uri.encodeComponent(message)}');

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  void _openDialPad() async {
    const phoneNumber = '+919770497756';
    final Uri url = Uri(scheme:'tel',path:phoneNumber);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/img/login.jpeg"),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Describe Your Problem",
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Name",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter your full name",
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Phone Number",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your phone number";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter your Phone Number",
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Address",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _addressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your address";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter your address",
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Problem",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedProblem,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedProblem = newValue;
                            _customProblem = null;
                            if (_selectedProblem != 'Other') {
                              _updateEstimatedCost(_selectedProblem!);
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select your problem";
                          }
                          return null;
                        },
                        items: _problems.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      if (_selectedProblem == 'Other')
                        TextFormField(
                          onChanged: (value) {
                            _customProblem = value;
                          },
                          validator: (value) {
                            if (_selectedProblem == 'Other' && (value == null || value.isEmpty)) {
                              return "Please enter your problem";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Please specify your problem",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      if (_selectedProblem != null && _selectedProblem != 'Other')
                        Text(
                          'Estimated Cost: $_estimatedCost',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _launchWhatsApp,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: const Color(0xffffbc11),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Text(
                                "Book Now",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Talk to us? ",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: _openDialPad,
                            child: const Text(
                              "Contact",
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xffffbc11)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
