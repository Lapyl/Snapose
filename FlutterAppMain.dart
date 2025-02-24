import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:archive/archive_io.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Snapose',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(title: 'SNAPOSE'),
        );
    }
}

class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key, required this.title});
    final String title;
    @override
    State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    String _output0 = '';
    String _output1 = '';
    String _output2 = '';
    String _output3 = '';
    String _output4 = '';
    String _output5 = '';
    final tEC = TextEditingController();
    Future<void> _aInst(BuildContext context, dynamic tEC) async {
        setState(() {
            _output0 = 'Install OpenPose model.';
        });
        String xoutput1 = 'https://github.com/CMU-Perceptual-Computing-Lab/openpose/releases/download/v1.7.0/openpose-1.7.0-binaries-win64-cpu-python3.7-flir-3d.zip';
        // String xoutput1 = 'https://lipy.us/snapose/openpose-1.7.0-binaries-win64-cpu-python3.7-flir-3d.zip';
        String xoutput2 = 'C:\\Programs\\openpose1';
        String xoutput3 = 'https://huggingface.co/camenduru/openpose/raw/f4a22b0e6fa2a4a2b1e2d50bd589e8bb11ebea7c/pose_iter_584000.caffemodel';
        // String xoutput3 = 'https://lipy.us/snapose/pose_iter_584000.caffemodel';
        String xoutput4 = '$xoutput2\\openpose\\pose_iter_584000.caffemodel';
        String xoutput5 = '$xoutput2\\openpose\\models\\pose\\body_25\\pose_iter_584000.caffemodel';
        try {
            await Directory(xoutput2).create(recursive: true);
            if (!File('$xoutput2\\x.zip').existsSync()) {        
                print('Downloading $xoutput1');
                HttpClient client = new HttpClient();
                var downloadData = List<int>.empty(growable: true);
                var fileSave = new File('$xoutput2\\x.zip');
                await client.getUrl(Uri.parse(xoutput1))
                .then((HttpClientRequest request) {
                    return request.close();
                })
                .then((HttpClientResponse response) {
                    response.listen((d) => downloadData.addAll(d),
                    onDone: () {
                        fileSave.writeAsBytes(downloadData);
                    });
                });
            }
            if (!File('$xoutput2\\openpose\\Version.txt').existsSync()) {
                print('Extracting $xoutput2\\x.zip');
                await extractFileToDisk('$xoutput2\\x.zip', xoutput2);
            }
            if (!File(xoutput4).existsSync()) {
                print('Downloading $xoutput3');
                HttpClient client = new HttpClient();
                var downloadData = List<int>.empty(growable: true);
                var fileSave = new File(xoutput4);
                client.getUrl(Uri.parse(xoutput3))
                .then((HttpClientRequest request) {
                    return request.close();
                })
                .then((HttpClientResponse response) {
                    response.listen((d) => downloadData.addAll(d),
                    onDone: () {
                        fileSave.writeAsBytes(downloadData);
                    });
                });
            }
            setState(() {
                _output1 = 'Downloaded: $xoutput1';
                _output2 = 'Extracted into: $xoutput2';
                _output3 = 'Downloaded: $xoutput3';
                _output4 = 'Placed in: $xoutput4';
                _output5 = 'Move it to: $xoutput5';
            });
        } catch (err) {
            print('Error: ${err.toString()}');
            _output1 = err.toString();
        }
    }
    Future<void> _aView(BuildContext context, dynamic tEC) async {
        setState(() {
            _output0 = 'View video of walking.';
        });
        await showDialog(
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: const Text('Path of video file of a person walking'),
                    content: TextField(
                    controller: tEC,
                    decoration: const InputDecoration(hintText: 'Write'),
                    ),
                    actions: <Widget>[
                        ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () => Navigator.pop(context, tEC.text),
                        ),
                        const Text("Wait"),
                    ],
                );
            }
        );
        String progdir = 'C:\\Programs\\openpose1\\openpose';
        String vidpath = tEC.text;        
        String outpdir = '$progdir\\bin\\out';
        await Directory(outpdir).create(recursive: true);
        final execomm = '$progdir\\bin\\OpenPoseDemo.exe --video "$vidpath" --write_json "$outpdir\\"';
        final process = await Process.start(execomm, [], runInShell: true);
        await stdout.addStream(process.stdout);
        await stderr.addStream(process.stderr);
        final exitCod = await process.exitCode;
        print('Exit code: ${exitCod.toString}');
        setState(() {
            _output1 = progdir;
            _output2 = vidpath;
            _output3 = outpdir;
            _output4 = execomm;
            _output5 = exitCod.toString();
        });
    }
    Future<void> _aAnim(BuildContext context, dynamic tEC) async {
        setState(() {
            _output0 = 'Animate key points of poses.';
        });
        await showDialog(
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: const Text('Path of top folder for lists of folders and files'),
                    content: TextField(
                    controller: tEC,
                    decoration: const InputDecoration(hintText: 'Write'),
                    ),
                    actions: <Widget>[
                        ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () => Navigator.pop(context, tEC.text),
                        ),
                        const Text("Wait"),
                    ],
                );
            }
        );
        String toppath = tEC.text;
        setState(() {
            _output1 = 'Path: $toppath';
        });
        String xoutput2 = '';
        String xoutput3 = '';
        String xoutput4 = '';
        try {
            final topFold = Directory(toppath);
            final List<FileSystemEntity> items = topFold.listSync(recursive: true, followLinks: false);
            for (var item in items.whereType<Directory>()) {
                xoutput3 = '$xoutput3${item.path.replaceAll('${topFold.path}\\','')}\n';                
            }
            for (var item in items.whereType<File>()) {
                xoutput4 = '$xoutput4${item.path.replaceAll('${topFold.path}\\','')}\n';                
            }
            File('$toppath\\ListDir.csv').writeAsStringSync(xoutput3);
            File('$toppath\\ListFil.csv').writeAsStringSync(xoutput4);
            xoutput2 = 'Lists: ListDir.csv, ListFil.csv';
            if (xoutput3.length > 200) { xoutput3 = '${xoutput3.substring(0, 200)}\n...'; }
            if (xoutput4.length > 1000) { xoutput4 = '${xoutput4.substring(0, 1000)}\n...'; }
        } catch (e) {
            xoutput2 = 'Lists not prepared';            
            xoutput3 = 'Error';
            xoutput4 = '$e';
        }
        setState(() {
            _output2 = xoutput2;
            _output3 = xoutput3;
            _output4 = xoutput4;
        });
    }
    Future<void> _aCast(BuildContext context, dynamic tEC) async {
        setState(() {
            _output0 = 'Cast animation on screen.';
        });
        await showDialog(
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: const Text('Path of top folder for lists of folders and files'),
                    content: TextField(
                    controller: tEC,
                    decoration: const InputDecoration(hintText: 'Write'),
                    ),
                    actions: <Widget>[
                        ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () => Navigator.pop(context, tEC.text),
                        ),
                        const Text("Wait"),
                    ],
                );
            }
        );
        String toppath = tEC.text;
        setState(() {
            _output1 = 'Path: $toppath';
        });
        String xoutput2 = '';
        String xoutput3 = '';
        String xoutput4 = '';
        try {
            final topFold = Directory(toppath);
            final List<FileSystemEntity> items = topFold.listSync(recursive: true, followLinks: false);
            for (var item in items.whereType<Directory>()) {
                xoutput3 = '$xoutput3${item.path.replaceAll('${topFold.path}\\','')}\n';                
            }
            for (var item in items.whereType<File>()) {
                xoutput4 = '$xoutput4${item.path.replaceAll('${topFold.path}\\','')}\n';                
            }
            File('$toppath\\ListDir.csv').writeAsStringSync(xoutput3);
            File('$toppath\\ListFil.csv').writeAsStringSync(xoutput4);
            xoutput2 = 'Lists: ListDir.csv, ListFil.csv';
            if (xoutput3.length > 200) { xoutput3 = '${xoutput3.substring(0, 200)}\n...'; }
            if (xoutput4.length > 1000) { xoutput4 = '${xoutput4.substring(0, 1000)}\n...'; }
        } catch (e) {
            xoutput2 = 'Lists not prepared';            
            xoutput3 = 'Error';
            xoutput4 = '$e';
        }
        setState(() {
            _output2 = xoutput2;
            _output3 = xoutput3;
            _output4 = xoutput4;
        });
    }
    Future<void> _aDiag(BuildContext context, dynamic tEC) async {
        setState(() {
            _output0 = 'Diagnose walking poses.';
        });
        await showDialog(
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: const Text('Path of top folder for lists of folders and files'),
                    content: TextField(
                    controller: tEC,
                    decoration: const InputDecoration(hintText: 'Write'),
                    ),
                    actions: <Widget>[
                        ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () => Navigator.pop(context, tEC.text),
                        ),
                        const Text("Wait"),
                    ],
                );
            }
        );
        String toppath = tEC.text;
        setState(() {
            _output1 = 'Path: $toppath';
        });
        String xoutput2 = '';
        String xoutput3 = '';
        String xoutput4 = '';
        try {
            final topFold = Directory(toppath);
            final List<FileSystemEntity> items = topFold.listSync(recursive: true, followLinks: false);
            for (var item in items.whereType<Directory>()) {
                xoutput3 = '$xoutput3${item.path.replaceAll('${topFold.path}\\','')}\n';                
            }
            for (var item in items.whereType<File>()) {
                xoutput4 = '$xoutput4${item.path.replaceAll('${topFold.path}\\','')}\n';                
            }
            File('$toppath\\ListDir.csv').writeAsStringSync(xoutput3);
            File('$toppath\\ListFil.csv').writeAsStringSync(xoutput4);
            xoutput2 = 'Lists: ListDir.csv, ListFil.csv';
            if (xoutput3.length > 200) { xoutput3 = '${xoutput3.substring(0, 200)}\n...'; }
            if (xoutput4.length > 1000) { xoutput4 = '${xoutput4.substring(0, 1000)}\n...'; }
        } catch (e) {
            xoutput2 = 'Lists not prepared';            
            xoutput3 = 'Error';
            xoutput4 = '$e';
        }
        setState(() {
            _output2 = xoutput2;
            _output3 = xoutput3;
            _output4 = xoutput4;
        });
    }
    Future<void> _aList(BuildContext context, dynamic tEC) async {
        setState(() {
            _output0 = 'List folders and files.';
        });
        await showDialog(
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: const Text('Path of top folder for lists of folders and files'),
                    content: TextField(
                    controller: tEC,
                    decoration: const InputDecoration(hintText: 'Write'),
                    ),
                    actions: <Widget>[
                        ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () => Navigator.pop(context, tEC.text),
                        ),
                        const Text("Wait"),
                    ],
                );
            }
        );
        String toppath = tEC.text;
        setState(() {
            _output1 = 'Path: $toppath';
        });
        String xoutput2 = '';
        String xoutput3 = '';
        String xoutput4 = '';
        try {
            final topFold = Directory(toppath);
            final List<FileSystemEntity> items = topFold.listSync(recursive: true, followLinks: false);
            for (var item in items.whereType<Directory>()) {
                xoutput3 = '$xoutput3${item.path.replaceAll('${topFold.path}\\','')}\n';                
            }
            for (var item in items.whereType<File>()) {
                xoutput4 = '$xoutput4${item.path.replaceAll('${topFold.path}\\','')}\n';                
            }
            File('$toppath\\ListDir.csv').writeAsStringSync(xoutput3);
            File('$toppath\\ListFil.csv').writeAsStringSync(xoutput4);
            xoutput2 = 'Lists: ListDir.csv, ListFil.csv';
            if (xoutput3.length > 200) { xoutput3 = '${xoutput3.substring(0, 200)}\n...'; }
            if (xoutput4.length > 1000) { xoutput4 = '${xoutput4.substring(0, 1000)}\n...'; }
        } catch (e) {
            xoutput2 = 'Lists not prepared';            
            xoutput3 = 'Error';
            xoutput4 = '$e';
        }
        setState(() {
            _output2 = xoutput2;
            _output3 = xoutput3;
            _output4 = xoutput4;
        });
    }    
    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
        ),
        body: Center(
            child: Row(
                children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            FloatingActionButton(
                                onPressed: () => _aInst(context, tEC),
                                tooltip: 'Install OpenPose model.',
                                child: const Icon(Icons.install_desktop),                                
                            ),
                            FloatingActionButton(
                                onPressed: () => _aView(context, tEC),
                                tooltip: 'View video of walking.',
                                child: const Icon(Icons.preview),
                            ),
                            FloatingActionButton(
                                onPressed: () => _aAnim(context, tEC),
                                tooltip: 'Animate key points of poses.',
                                child: const Icon(Icons.animation),
                            ),
                            FloatingActionButton(
                                onPressed: () => _aCast(context, tEC),
                                tooltip: 'Cast animation on screen.',
                                child: const Icon(Icons.cast),
                            ),
                            FloatingActionButton(
                                onPressed: () => _aDiag(context, tEC),
                                tooltip: 'Diagnose walking poses.',
                                child: const Icon(Icons.check_box),
                            ),
                            FloatingActionButton(
                                onPressed: () => _aList(context, tEC),
                                tooltip: 'List folders and files.',
                                child: const Icon(Icons.format_list_bulleted),
                            ),
                        ],
                    ),
                    Padding(padding: const EdgeInsets.all(10.0)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Text(
                                _output0,
                                style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Text('-----------------------------------------------'),
                            Text(
                                _output1,
                                style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Text('-----------------------------------------------'),
                            Text(
                                _output2,
                                style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Text('-----------------------------------------------'),
                            Text(
                                _output3,
                                style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const Text('-----------------------------------------------'),
                            Text(
                                _output4,
                                style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const Text('-----------------------------------------------'),
                            Text(
                                _output5,
                                style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const Text('-----------------------------------------------'),
                        ],
                    ),
              ],
            ),
        ),
    );
  }
  
  void download(Future<Response> stream, String s) {}
}