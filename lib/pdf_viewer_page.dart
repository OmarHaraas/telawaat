import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  int _lastPage = 1; // Initialize _lastPage with a default value
  PdfViewerController _pdfViewerController =
      PdfViewerController(); // Initialize _pdfViewerController
  bool isLoading = true;
  @override
  void initState() {
    _loadLastPage();
    super.initState();
    isLoading = false;
  }

  _loadLastPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastPage = prefs.getInt('lastPage') ?? 1;
    });
  }

  _saveLastPage(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastPage', page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SfPdfViewer.asset(
        "assets/books/fqh.pdf",
        controller: _pdfViewerController,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          _pdfViewerController.jumpToPage(_lastPage);
        },
        onPageChanged: (PdfPageChangedDetails details) {
          _saveLastPage(details.newPageNumber);
        },
      ),
    );
  }
}
