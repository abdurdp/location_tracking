import 'package:flutter/material.dart';

class DivisionThanaDropdowns extends StatefulWidget {
  @override
  _DivisionThanaDropdownsState createState() => _DivisionThanaDropdownsState();
}

class _DivisionThanaDropdownsState extends State<DivisionThanaDropdowns>
    with TickerProviderStateMixin {
  // Sample data for divisions and thanas
  final List<Division> divisions = [
    Division(id: 0, name: 'Dhaka'),
    Division(id: 1, name: 'Rajshahi'),
    Division(id: 2, name: 'Chittagong'),
  ];

  // Thana data associated with divisions
  final Map<int, List<String>> thanasByDivision = {
    0: ['Thana A', 'Thana B', 'Thana C'],
    1: ['Thana U', 'Thana I', 'Thana O'],
    2: ['Thana X', 'Thana Y', 'Thana Z'],
  };

  // Image data associated with Thanas
  final Map<int, List<String>> imagesByThanas = {
    0: [
      'https://cdn.britannica.com/97/189797-050-1FC0041B/Night-view-Dhaka-Bangladesh.jpg?w=300',
      'https://cdn.britannica.com/52/148852-050-56A78A2A/National-Assembly-Building-Bangladesh-Dhaka-Louis-I.jpg?w=300',
      'https://content.r9cdn.net/rimg/dimg/c9/06/8d4fe0d8-city-28030-164fcc85915.jpg?crop=true&width=1020&height=498'
    ],
    1: [
      'https://dailyasianage.com/library/1662403733_8.jpg',
      'https://www.rajshahiexpress.com/wp-content/uploads/2023/07/plan-chottor-Road-1536x1024.jpeg',
      'https://www.rajshahiexpress.com/wp-content/uploads/2023/05/344291328_3410529005828211_2159438581139938303_n-1536x1024.jpg'
    ],
    2: [
      'https://www.tranigo.com/image/Chattogram%20airport%20transfers',
      'https://www.tranigo.com/image/Chattogram%20airport%20shuttle',
      'https://www.tranigo.com/image/Chattogram%20airport%20taxi'
    ],
  };

  // Image data associated with Thanas
  final Map<String, String> imageByThanas = {
    'Thana A':
        'https://cdn.britannica.com/97/189797-050-1FC0041B/Night-view-Dhaka-Bangladesh.jpg?w=300',
    'Thana B':
        'https://cdn.britannica.com/52/148852-050-56A78A2A/National-Assembly-Building-Bangladesh-Dhaka-Louis-I.jpg?w=300',
    'Thana C':
        'https://content.r9cdn.net/rimg/dimg/c9/06/8d4fe0d8-city-28030-164fcc85915.jpg?crop=true&width=1020&height=498',
    'Thana U': 'https://dailyasianage.com/library/1662403733_8.jpg',
    'Thana I':
        'https://www.rajshahiexpress.com/wp-content/uploads/2023/07/plan-chottor-Road-1536x1024.jpeg',
    'Thana O':
        'https://www.rajshahiexpress.com/wp-content/uploads/2023/05/344291328_3410529005828211_2159438581139938303_n-1536x1024.jpg',
    'Thana X': 'https://www.tranigo.com/image/Chattogram%20airport%20transfers',
    'Thana Y': 'https://www.tranigo.com/image/Chattogram%20airport%20shuttle',
    'Thana Z': 'https://www.tranigo.com/image/Chattogram%20airport%20taxi',
  };

  int? selectedDivisionId = null;
  String? selectedThana = null;
  String? selectedImage = null;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bangladesh Division and Thana'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Division Dropdown
              Card(
                color: Colors.blue.shade100,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: DropdownButton<int>(
                    hint: Text('Select Division'),
                    value:
                        selectedDivisionId != null ? selectedDivisionId : null,
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedDivisionId = newValue!;
                        selectedThana =
                            null; // Clear the selected thana when division changes
                        _controller.reverse();
                      });
                      // Show the thana dialog when a division is selected

                        _showThanaDialog(context);

                    },
                    items: divisions.map((division) {
                      return DropdownMenuItem<int>(
                        value: division.id,
                        child: Text(division.name),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Thana Dropdown
              Card(
                color: Colors.blue.shade100,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    hint: Text('Select Thana'),
                    value: selectedThana,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedThana = newValue!;
                        _controller.forward();
                      });
                    },
                    items: selectedDivisionId != null
                        ? thanasByDivision[selectedDivisionId]?.map((thana) {
                            return DropdownMenuItem<String>(
                              value: thana,
                              child: Text(thana),
                            );
                          }).toList()
                        : [],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Horizontal Scroll View for Images
              Container(
                height: 150, // Adjust the height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imagesByThanas[selectedDivisionId]?.length ?? 0,
                  itemBuilder: (context, index) {
                    final imageUrl = imagesByThanas[selectedDivisionId]![index];
                    return Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Image.network(
                          imageUrl,
                          width: 150, // Adjust the image width
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              Visibility(
                visible: selectedThana != null,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: SizeTransition(
                    sizeFactor: CurvedAnimation(
                      parent: AnimationController(
                        vsync: this,
                        duration: Duration(milliseconds: 500),
                      )..forward(),
                      curve: selectedThana != null
                          ? Curves.easeIn
                          : Curves.easeOut,
                    ),
                    child: Container(
                      child: selectedThana != null
                          ? Card(
                              elevation: 5,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Image.network(
                                  imageByThanas[selectedThana!]!,
                                  height: 250, // Adjust the image width
                                ),
                              ),
                            )
                          : Container(),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showThanaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Thana'),
          children: thanasByDivision[selectedDivisionId]?.map((thana) {
            return SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedThana = thana;
                });
                Navigator.pop(context);
              },
              child: Text(thana),
            );
          }).toList(),
        );
      },
    );
  }
  @override
  void deactivate() {
    _controller.dispose();
    super.deactivate();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Division {
  final int id;
  final String name;

  Division({required this.id, required this.name});
}
