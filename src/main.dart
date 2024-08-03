import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'DataBase.dart';
import 'DataClass.dart';
import 'FavPageView.dart';
import 'Genes/ListPageView.dart';
import 'Monsties/ListPageView.dart';
import 'Quests/ListPageView.dart';
import 'Skills/ListPageView.dart';

Future<void> requestPermissions() async {
  await Permission.manageExternalStorage.request();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();
  await DataClass().initialize();
  await DataBase().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MH Stories DataBase',
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: const MyHomePage(title: 'MH Stories DataBase'),
    );
  }
}

class TabModel extends ChangeNotifier {
  int _selectedTabIndex = 0;
  String _filter = 'all';

  int get selectedTabIndex => _selectedTabIndex;
  String get filter => _filter;

  void setTabIndex(int index) {
    _selectedTabIndex = index;
    _updateFilter();
    notifyListeners();
  }

  void _updateFilter() {
    switch (_selectedTabIndex) {
      case 0:
        _filter = 'filter1';
        break;
      case 1:
        _filter = 'filter2';
        break;
    // ... other cases
      default:
        _filter = 'all';
    }
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = TextEditingController();
  String filter = "";

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
      bottom: TabBar(
        tabs: [
          Tab(child: Image.asset("assets/Unknown_icon.png"),),
          Tab(child: Image.asset("assets/quest_icon.png"),),
          Tab(child: Image.asset("assets/genes_icon.png"),),
          Tab(child: Image.asset("assets/skills_icon.png"),),
          const Tab(icon: Icon(Icons.favorite, color: Colors.red,),)
        ],
      ),
    );

    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: appBar,
          body: TabBarView(
            children: [
              MonstiesListView(height: appBar.preferredSize.height),
              QuestsListView(height: appBar.preferredSize.height),
              GenesListView(height: appBar.preferredSize.height),
              SkillsListView(height: appBar.preferredSize.height),
              FavListView(height: appBar.preferredSize.height),
            ],
          ),
        )
    );
  }
}
