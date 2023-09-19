import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ApiExplorerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Explorer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ApiExplorerScreen(),
    );
  }
}

class ApiExplorerScreen extends StatefulWidget {
  @override
  _ApiExplorerScreenState createState() => _ApiExplorerScreenState();
}

class _ApiExplorerScreenState extends State<ApiExplorerScreen> {
  final String apiUrl =
      "http://apis.data.go.kr/6260000/BusanNursingroomInfoService/getNursingroomInfo";

  final String serviceKey =
      "a3GptWb07Pi1Gxv7GDsZ195JQT%2BehIA65OSl04QTsSyaxeTIMA6Y7ZMOa9tIv7ywXzaqW5lWgpU4fjoRTT1lDA%3D%3D";

  final String searchKeyword = "영도도서관";

  @override
  void initState() {
    super.initState();
    fetchData(); // 데이터 로딩을 initState()에서 호출합니다.
  }

  Future<String> fetchData() async {
    final url = Uri.parse(
        "$apiUrl?serviceKey=$serviceKey&pageNo=1&numOfRows=10&sj=$searchKeyword&resultType=json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  void copyAddressToClipboard(String address) async {
    await Clipboard.setData(ClipboardData(text: address));
    Fluttertoast.showToast(
      msg: '주소가 복사되었습니다.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API Explorer')),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // 데이터를 파싱하고 원하는 형태로 표시하는 로직을 추가하세요.
              // 예시로 주소를 터치했을 때 복사되도록 구현합니다.
              final address = '주소 데이터'; // 파싱한 주소 데이터

              return GestureDetector(
                onTap: () => copyAddressToClipboard(address),
                child: Text(address),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
