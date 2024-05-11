import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobfinderapp/constants/app_constants.dart';
import 'package:jobfinderapp/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobfinderapp/services/helpers/book_helper.dart';

class BookNotifier extends ChangeNotifier {
  late Future<List<AllBookMarks>> bookmarks;
  
  bool _bookmark = false;
  bool get bookmark => _bookmark;
  set isBookMark(bool newState) {
    if (_bookmark != newState) {
      _bookmark = newState;
      notifyListeners();
    }
  }

  String _bookmarkId = '';
  String get bookmarkId => _bookmarkId;
  set isBookMarkId(String newState) {
    if (_bookmarkId != newState) {
      _bookmarkId = newState;
      notifyListeners();
    }
  }

  addBookmark(String model) {
    BookMarkHelper.addBookmark(model).then((bookmark) {
      isBookMark = true;
      isBookMarkId = bookmark.bookmarkId;
    });
  }

  getBookmark(String jobId) {
    var bookmark = BookMarkHelper.getBookmark(jobId);
    bookmark.then((value) => {
          if (value == null){
            isBookMark = false, isBookMarkId = '',
            // print("null1")
            }
            
          else
            {isBookMark = true, isBookMarkId = value.bookmarkId}
        });
  }

  // getBookmark(String jobId) {
  //   BookMarkHelper.getBookmark(jobId).then((bookmark) {
  //     if (bookmark == null) {
  //       isBookMark = false;
  //     } else {
  //       isBookMark = bookmark.status;
  //       isBookMarkId = bookmark.bookmarkId;
  //     }
  //   });
  // }

  deleteBookMark(String jobId) {
    BookMarkHelper.deleteBookmarks(jobId).then((value) {
      if (value) {
        Get.snackbar(
          "Bookmark succesfully deleted",
          "Visit the bookmarks page to see changes",
          colorText: Color(kLight.value),
          backgroundColor: Color(kOrange.value),
          icon: const Icon(Icons.bookmark_remove_outlined),
        );
      }
      isBookMark = false;
    });
  }

  Future<List<AllBookMarks>> getBookMarks() {
    bookmarks = BookMarkHelper.getAllBookmark();

    return bookmarks;
  }
}
