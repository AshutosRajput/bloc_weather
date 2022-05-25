// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  String? _cityName;
  bool isValidating = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void _submit() async {
    setState(() {
      isValidating = !isValidating;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(_cityName!.trim());
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Search'),
        ),
        body: Stack(
          children: [
            Align(
              alignment: const Alignment(0, -0.65),
              child: Image.asset(
                'assets/images/weather.png',
                height: 160,
                width: 160,
              ),
            ),
            Form(
                key: _formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'City Name',
                          hintText: 'Enter City Name',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (String? input) {
                          if (input!.isEmpty || input.trim().length < 2) {
                            return 'Please enter a valid city name';
                          }
                          return null;
                        },
                        onSaved: (String? input) {
                          _cityName = input;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 50,
                      width: 220,
                      child: ElevatedButton.icon(
                        onPressed: () => _submit(),
                        icon: isValidating == false
                            ? const Icon(Icons.search)
                            : Container(),
                        label: isValidating == false
                            ? const Text(
                                'How\'s the weather?',
                                style: TextStyle(fontSize: 18),
                              )
                            : const SizedBox(
                                height: 28,
                                width: 28,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
