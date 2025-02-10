import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class FileUploadWidget extends StatefulWidget {
  final String type;
  final double maxFileSize;
  final Function(FileUpload) onFileUploaded;
  const FileUploadWidget({
    super.key,
    required this.type,
    required this.maxFileSize,
    required this.onFileUploaded,
  });

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  File? _file;
  VideoPlayerController? _videoController;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFile() async {
    if (widget.type == 'image') {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _file = File(pickedFile.path);
          _videoController = null;
        });
        widget.onFileUploaded(FileUpload(
          fileType: 'Image',
          uploadedFileUrl: _file!.path,
          maxFileSize: '${widget.maxFileSize} MB',
        ));
      }
    } else if (widget.type == 'video') {
      final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _file = File(pickedFile.path);
          _videoController = VideoPlayerController.file(_file!)
            ..initialize().then((_) {
              setState(() {});
            });
        });
        widget.onFileUploaded(FileUpload(
          fileType: 'Video',
          uploadedFileUrl: _file!.path,
          maxFileSize: '${widget.maxFileSize} MB',
        ));
      }
    }
  }

  Future<void> _captureFile() async {
    if (widget.type == 'image') {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _file = File(pickedFile.path);
          _videoController = null;
        });
        widget.onFileUploaded(FileUpload(
          fileType: 'Image',
          uploadedFileUrl: _file!.path,
          maxFileSize: '${widget.maxFileSize} MB',
        ));
      }
    } else if (widget.type == 'video') {
      final pickedFile = await _picker.pickVideo(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _file = File(pickedFile.path);
          _videoController = VideoPlayerController.file(_file!)
            ..initialize().then((_) {
              setState(() {});
            });
        });
        widget.onFileUploaded(FileUpload(
          fileType: 'Video',
          uploadedFileUrl: _file!.path,
          maxFileSize: '${widget.maxFileSize} MB',
        ));
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_file == null)
          Column(
            children: [
              ElevatedButton(
                onPressed: _captureFile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFCF2F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.type == 'image'
                          ? Icons.camera_alt
                          : Icons.videocam,
                      color: Colors.red,
                    ),
                    SizedBox(width: 8),
                    Text(
                      widget.type == 'image' ? "Capture" : "Record",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickFile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEAEFF7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload, color: Colors.blue),
                    SizedBox(width: 8),
                    Text("Upload", style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Max file size: ${widget.maxFileSize}MB",
                style: TextStyle(fontSize: 14.0, color: Color(0xFFEAEFF7)),
              ),
            ],
          )
        else
          Column(
            children: [
              Container(
                width: 296,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[200],
                ),
                child: widget.type == 'image'
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(_file!, fit: BoxFit.cover),
                      )
                    : _videoController != null &&
                            _videoController!.value.isInitialized
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: AspectRatio(
                                  aspectRatio:
                                      _videoController!.value.aspectRatio,
                                  child: VideoPlayer(_videoController!),
                                ),
                              ),
                              if (!_videoController!.value.isPlaying)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _videoController!.play();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.play_arrow,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          )
                        : Center(child: CircularProgressIndicator()),
              ),
              SizedBox(height: 16),
              Text(
                "Upload a different ${widget.type} file?",
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _captureFile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFCF2F2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          widget.type == 'image'
                              ? Icons.camera_alt
                              : Icons.videocam,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          widget.type == 'image' ? "Capture" : "Record",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _pickFile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEAEFF7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.upload, color: Colors.blue),
                        SizedBox(width: 8),
                        Text("Upload", style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}

class FileUpload {
  final String? fileType; // "Video", "Audio", "Image"
  final String? uploadedFileUrl; // URL or path of the uploaded file
  final String? maxFileSize; // Maximum allowed file size (e.g., "10 MB")

  FileUpload({
    this.fileType,
    this.uploadedFileUrl,
    this.maxFileSize,
  });

  factory FileUpload.fromJson(Map<String, dynamic> json) {
    return FileUpload(
      fileType: json['fileType'],
      uploadedFileUrl: json['uploadedFileUrl'],
      maxFileSize: json['maxFileSize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileType': fileType,
      'uploadedFileUrl': uploadedFileUrl,
      'maxFileSize': maxFileSize,
    };
  }

  // Copy constructor for immutability
  FileUpload copyWith({
    String? fileType,
    String? uploadedFileUrl,
    String? maxFileSize,
  }) {
    return FileUpload(
      fileType: fileType ?? this.fileType,
      uploadedFileUrl: uploadedFileUrl ?? this.uploadedFileUrl,
      maxFileSize: maxFileSize ?? this.maxFileSize,
    );
  }
}
