import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginuicolors/dashboard.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController taskController = TextEditingController();
  String? _selectedPriority;
  final List<String> items = [
    'Kathmandu',
    'Pokhara',
    'Bhaktapur',
    'Patan',
    'Chitwan',
    'Jhapa',
    'Hetauda',
  ];

  String? selectedLocation;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  File? _pickedImage;

  Future<void> _captureImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    } else {}
  }

  void _navigateBackToDashboard() {
    Task task = Task(
      taskName: taskController.text,
      priority: _selectedPriority ?? '',
      location: selectedLocation ?? '',
      description: descriptionController.text,
      image: _pickedImage,
    );

    Navigator.pop(context, task); // Pass the task back to Dashboard
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 199, 68, 68).withOpacity(0.8),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ADD TASK',
          style: TextStyle(
      color: Color.fromARGB(255, 0, 51, 102),
      fontWeight: FontWeight.bold,
        ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Task",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900], // Set font color to dark blue
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: taskController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Task Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900], // Set font color to dark blue
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Priority",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900], // Set font color to dark blue
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedPriority,
                  items: ['High', 'Normal'].map((priority) {
                    return DropdownMenuItem<String>(
                      value: priority,
                      child: Text(priority),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPriority = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Priority',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Location",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900], // Set font color to dark blue
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedLocation,
                    onChanged: (value) {
                      setState(() {
                        selectedLocation = value;
                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 200,
                    ),
                    dropdownStyleData: const DropdownStyleData(
                      maxHeight: 200,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                    dropdownSearchData: DropdownSearchData(
                      searchController: textEditingController,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Container(
                        height: 50,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: textEditingController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for an item...',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return item.value.toString().contains(searchValue);
                      },
                    ),

                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        textEditingController.clear();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                _pickedImage == null
                    ? const Text('No image selected.')
                    : Image.file(_pickedImage!),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _captureImage,
                  child: const Text("Take Picture"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _navigateBackToDashboard, // Updated function name
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
