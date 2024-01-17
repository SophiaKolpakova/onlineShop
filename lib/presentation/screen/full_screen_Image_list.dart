import 'package:flutter/material.dart';

class FullScreenImageList extends StatefulWidget {
  final List<String> imagePaths;

  const FullScreenImageList({Key? key, required this.imagePaths}) : super(key: key);

  @override
  _FullScreenImageListState createState() => _FullScreenImageListState();
}

class _FullScreenImageListState extends State<FullScreenImageList> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          // Swipe right
          if (details.primaryVelocity! > 0 && _currentPage > 0) {
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
          // Swipe left
          else if (details.primaryVelocity! < 0 && _currentPage < widget.imagePaths.length - 1) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.imagePaths.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return Center(
              child: Image.network(
                widget.imagePaths[index],
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}