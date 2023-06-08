import 'package:flutter/material.dart';

void main() {
  runApp(DartApp());
}

class Node {
  String text;
  Node? leftChild;
  Node? rightChild;

  Node(this.text, {this.leftChild, this.rightChild});
  bool isLeafNode() {
    return leftChild == null && rightChild == null;
  }
}

class DartApp extends StatefulWidget {
  @override
  _DartAppState createState() => _DartAppState();
}

class _DartAppState extends State<DartApp> {
  Node? _rootNode;
  Node? _currentNode;
  bool? _isLeafNode;

  @override
  void initState() {
    super.initState();
    // Hier kannst du deine Baumstruktur aufbauen
    // Beispielbaum:
    //       A
    //     /   \
    //    B     C
    //   / \   / \
    //  D   E F   G
    _rootNode = Node(
      'Interessierst du dich für das Thema "Immobilien"?',
      leftChild: Node(
        'Scheust du dich vor Zahlen?',
        leftChild: Node(
          'Hast du gerne Kontak mit Menschen/Kunden und bist du gerne viel unterwegs?',
          leftChild: Node('Immo AD'),
          rightChild: Node('Immo ID'),
        ),
        rightChild: Node(
          'Hast du gerne Kontak mit Menschen/Kunden und bist du gerne viel unterwegs?',
          leftChild: Node(
            'Bist du an stetige Weiterbildungen interssiert?',
            leftChild: Node('Bank AD-Plus'),
            rightChild: Node('Bank AD'),
          ),
          rightChild: Node('Bank ID'),
        ),
      ),
      rightChild: Node(
        'Interessierst du dich für Technik und bist gerne am PC?',
        leftChild: Node('Informatik'),
        rightChild: Node('Du bist hier falsch'),
      ),
    );

    _currentNode = _rootNode;
    _isLeafNode = _currentNode!.isLeafNode();
  }

  void _navigateToNextNode(bool isYesButtonPressed) {
    setState(() {
      if (_isLeafNode!) {
        return;
      }
      if (isYesButtonPressed) {
         _currentNode = _currentNode!.leftChild; 
      } else {
        _currentNode = _currentNode!.rightChild;
      }
      _isLeafNode = _currentNode!.isLeafNode();
    });
  }
  
  
  void _restart() {
    setState(() {
      _currentNode = _rootNode;
      _isLeafNode = _currentNode!.isLeafNode();
    });
  }
  
  @override
  Widget build(BuildContext context) {
   bool isLeafNode = _currentNode!.isLeafNode();
   List<Widget> buttons = [];

    if (!isLeafNode) {
      buttons = [
        ElevatedButton(
          onPressed: () {
            _navigateToNextNode(true);
          },
          child: Text('Ja'),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            _navigateToNextNode(false);
          },
          child: Text('Nein'),
        ),
      ];
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Survey'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentNode!.text,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              if (buttons.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buttons,
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _restart,
                child: Text('Neustart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}