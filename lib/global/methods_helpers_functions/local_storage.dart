import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task/features/main_view/models/video_model.dart';

class VideoDatabaseHelper {
  static VideoDatabaseHelper?
      videoDatabaseHelper; //Singleton object of the class
  static Database? _database;

  String videoTable = 'Videos';
  String id = 'id';
  String url = 'cdn_url';
  String userId = 'user_id';
  String title = 'title';
  String thumbUrl = 'thumb_cdn_url';
  String videoHeight = 'video_height';
  String videoWidth = 'video_width';
  String totalViews = 'total_views';
  String totalLikes = 'total_likes';
  String totalComments = 'total_comments';
  String totalShare = 'total_share';
  String totalWishlist = 'total_wishlist';
  String addedAt = 'byte_added_on';
  String aspectRatio = 'video_aspect_ratio';
  String duration = 'duration';

  String fullName = 'fullname	';
  String userName = 'username';
  String profilePictureUrl = 'profile_picture_cdn';
  String designation = 'designation';

  VideoDatabaseHelper._createInstance();

  factory VideoDatabaseHelper() {
    //initializing the object
    videoDatabaseHelper ??= VideoDatabaseHelper._createInstance();
    return videoDatabaseHelper!;
  }

  // Getter for our database
  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  // Function to initialize the database
  Future<Database> initializeDatabase() async {
    // Getting directory path for both Android and iOS
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}video.db';
    // Open or create database at a given path.
    var videoDatabase =
        await openDatabase(path, version: 1, onCreate: _createTable);
    debugPrint("Database Created");
    return videoDatabase;
  }

  // Function for creating a Table
  void _createTable(Database db, int newVersion) async {
    if (_database == null) {
      await db.execute(
          'CREATE TABLE $videoTable ($id INT, $url TEXT , $userId INT , $title TEXT , $thumbUrl TEXT , $videoHeight INT , $videoWidth INT , $totalViews INT, $totalLikes INT, $totalComments INT, $totalShare INT, $totalWishlist INT, $addedAt TEXT,  $aspectRatio TEXT , $duration INT, $fullName TEXT, $userName TEXT, $profilePictureUrl TEXT, $designation TEXT)');
    }
  }

  //Fetch Video
  Future<List<Map<String, dynamic>>> getVideo(String id) async {
    Database db = await database;
    var result =
        await db.rawQuery('SELECT * FROM $videoTable WHERE $id = \'$id\' ');
    return result;
  }

  //Fetch All Videos
  Future<List<VideoModel>> getAllVideos() async {
    Database db = await database;
    var result = await db.rawQuery('SELECT * FROM $videoTable');

    List<VideoModel> videos =
        result.map((e) => VideoModel.fromLocalStorageJson(e)).toList();
    return videos;
  }

  // Insert Many Videos Operation
  Future<void> insertManyVideosToTable(List<VideoModel> videos) async {
    Database db = await database;
    for (int x = 0; x < videos.length; x++) {
      await db.insert(videoTable, VideoModel.toLocalStorage(video: videos[x]));
    }
  }

  // Delete All Videos
  Future<void> deleteAllVideos() async {
    Database db = await database;
    await db.delete(videoTable);
  }
}

class UserVideosDatabaseHelper {
  static UserVideosDatabaseHelper?
      userVideosDatabaseHelper; //Singleton object of the class
  static Database? _database;

  String videosTable = 'user_videos';
  String id = 'id';
  String url = 'cdn_url';
  String userId = 'user_id';
  String title = 'title';
  String thumbUrl = 'thumb_cdn_url';
  String videoHeight = 'video_height';
  String videoWidth = 'video_width';
  String totalViews = 'total_views';
  String totalLikes = 'total_likes';
  String totalComments = 'total_comments';
  String totalShare = 'total_share';
  String totalWishlist = 'total_wishlist';
  String addedAt = 'byte_added_on';
  String aspectRatio = 'video_aspect_ratio';
  String duration = 'duration';

  String fullName = 'fullname	';
  String userName = 'username';
  String profilePictureUrl = 'profile_picture_cdn';
  String designation = 'designation';

  UserVideosDatabaseHelper._createInstance();

  factory UserVideosDatabaseHelper() {
    //initializing the object
    userVideosDatabaseHelper ??= UserVideosDatabaseHelper._createInstance();
    return userVideosDatabaseHelper!;
  }

  // Getter for our database
  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  // Function to initialize the database
  Future<Database> initializeDatabase() async {
    // Getting directory path for both Android and iOS
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}user_videos.db';
    // Open or create database at a given path.
    var videoDatabase =
        await openDatabase(path, version: 1, onCreate: _createTable);
    debugPrint("Database Created");
    return videoDatabase;
  }

  // Function for creating a Table
  void _createTable(Database db, int newVersion) async {
    if (_database == null) {
      await db.execute(
          'CREATE TABLE $videosTable ($id INT, $url TEXT , $userId INT , $title TEXT , $thumbUrl TEXT , $videoHeight INT , $videoWidth INT , $totalViews INT, $totalLikes INT, $totalComments INT, $totalShare INT, $totalWishlist INT, $addedAt TEXT,  $aspectRatio TEXT , $duration INT, $fullName TEXT, $userName TEXT, $profilePictureUrl TEXT, $designation TEXT)');
    }
  }

  //Fetch Video
  Future<List<Map<String, dynamic>>> getVideo(String id) async {
    Database db = await database;
    var result =
        await db.rawQuery('SELECT * FROM $videosTable WHERE $id = \'$id\' ');
    return result;
  }

  //Fetch All Videos
  Future<List<VideoModel>> getAllVideos() async {
    Database db = await database;
    var result = await db.rawQuery('SELECT * FROM $videosTable');

    List<VideoModel> videos =
        result.map((e) => VideoModel.fromLocalStorageJson(e)).toList();
    return videos;
  }

  // Insert Many Videos Operation
  Future<void> insertManyVideosToTable(List<VideoModel> videos) async {
    Database db = await database;
    for (int x = 0; x < videos.length; x++) {
      await db.insert(videosTable, VideoModel.toLocalStorage(video: videos[x]));
    }
  }

  // Delete All Videos
  Future<void> deleteAllVideos() async {
    Database db = await database;
    await db.delete(videosTable);
  }
}
