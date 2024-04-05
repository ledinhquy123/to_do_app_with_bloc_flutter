import 'package:flutter/material.dart';
import 'package:to_do_app/screens/add_task_screen.dart';
import 'package:to_do_app/screens/completed_tasks_screen.dart';
import 'package:to_do_app/screens/favourite_tasks_screen.dart';
import 'package:to_do_app/screens/my_drawer.dart';
import 'package:to_do_app/screens/peding_tasks_screen.dart';

// ignore: must_be_immutable
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    { 'pageName': const PedingTasksScreen(), 'title': 'Pending Tasks' },
    { 'pageName': const CompletedTasksScreen(), 'title': 'Completed Tasks' },
    { 'pageName': const FavouriteTasksScreen(), 'title': 'Favourite Tasks' }
  ];

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom // Get the emulator's keyboard height 
          ),
          child: AddTaskScreen(),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageDetails[_selectedPageIndex]['title'].toString()
        ),
        actions: [
          IconButton(onPressed: () => _addTask(context), icon: const Icon(Icons.add))
        ],
      ),
      drawer: MyDrawer(),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0 
        ? FloatingActionButton(
          onPressed: () => _addTask(context),
          tooltip: 'Add Task',
          child: const Icon(Icons.add),
        ) 
        : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.incomplete_circle_sharp),
            label: 'Pending Tasks'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Completed Tasks'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite Tasks'
          )
        ]
      ),
    );
  }
}