import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';
import 'package:screenshot/screenshot.dart';
import 'package:viswals_flutter_interview_task/models/country.dart';
import 'package:viswals_flutter_interview_task/utils/enums.dart';

class UserProfileProvider with ChangeNotifier {
  var _currentQuizzSection = UserProfileQuizzSection.documentType;
  DocumentType? _documentType;
  String? _documentNumber;
  Country? _documentCountry;
  XFile? _pickedPhoto;
  final _profilePhotoController = PhotoViewController();
  final _profilePhotoScreenshotController = ScreenshotController();
  Uint8List? _profilePhoto;
  var _isProfilePhotoReady = false;
  final _cardPhotoController = PhotoViewController();
  final _cardPhotoScreenshotController = ScreenshotController();
  Uint8List? _cardPhoto;
  var _isCardPhotoReady = false;

  @override
  void dispose() {
    _profilePhotoController.dispose();
    _cardPhotoController.dispose();
    super.dispose();
  }

  UserProfileQuizzSection get currentQuizzSection => _currentQuizzSection;

  DocumentType? get documentType => _documentType;

  String? get documentNumber => _documentNumber;

  Country? get documentCountry => _documentCountry;

  XFile? get pickedPhoto => _pickedPhoto;

  PhotoViewController get profilePhotoController => _profilePhotoController;

  ScreenshotController get profilePhotoScreenshotController =>
      _profilePhotoScreenshotController;

  Uint8List? get profilePhoto => _profilePhoto;

  bool get isProfilePhotoReady => _isProfilePhotoReady;

  PhotoViewController get cardPhotoController => _cardPhotoController;

  ScreenshotController get cardPhotoScreenshotController =>
      _cardPhotoScreenshotController;

  Uint8List? get cardPhoto => _cardPhoto;

  bool get isCardPhotoReady => _isCardPhotoReady;

  bool quizzStepCompletenessChecker(int step) => switch (step) {
        1 => _documentType != null,
        2 => _documentNumber != null && _documentCountry != null,
        3 => _isProfilePhotoReady && _isCardPhotoReady,
        _ => false,
      };

  double quizzCompletenessPercentage() {
    var completenessCounter = 0;
    const totalInformation = 4;

    if (_documentType != null) completenessCounter += 1;

    if (_documentNumber != null) completenessCounter += 1;

    if (_documentCountry != null) completenessCounter += 1;

    if (_isProfilePhotoReady && _isCardPhotoReady) {
      completenessCounter += 1;
    }

    return (completenessCounter / totalInformation) * 100;
  }

  bool canSkip() => switch (_currentQuizzSection) {
        UserProfileQuizzSection.documentType => _documentType == null,
        UserProfileQuizzSection.documentNumberAndCountry =>
          _documentNumber == null || _documentCountry == null,
        _ => false,
      };

  void setDocumentType(DocumentType type) {
    _documentType = type;
    notifyListeners();
  }

  void setDocumentNumber(String number) {
    _documentNumber = number;
    notifyListeners();
  }

  void setDocumentCountry(Country country) {
    _documentCountry = country;
    notifyListeners();
  }

  void setPickedPhoto(XFile photo) {
    _profilePhotoController.reset();
    _cardPhotoController.reset();
    _pickedPhoto = photo;
    _isProfilePhotoReady = false;
    _isCardPhotoReady = false;
    notifyListeners();
  }

  String getPickedPhotoExtension() => _pickedPhoto!.name.split('.').last;

  void setProfilePhoto(Uint8List photo) {
    _profilePhoto = photo;
    notifyListeners();
  }

  void checkProfilePhoto({
    required bool value,
    required Uint8List? photo,
  }) {
    _isProfilePhotoReady = value;
    _profilePhoto = photo;
    notifyListeners();
  }

  void checkCardPhoto({
    required bool value,
    required Uint8List? photo,
  }) {
    _isCardPhotoReady = value;
    _cardPhoto = photo;
    notifyListeners();
  }

  void resetPhotoPlanning() {
    _profilePhotoController.reset();
    _cardPhotoController.reset();
    _pickedPhoto = null;
    _isProfilePhotoReady = false;
    _isCardPhotoReady = false;
    notifyListeners();
  }

  void skipSection() {
    switch (_currentQuizzSection) {
      case UserProfileQuizzSection.documentType:
        _documentType = null;

      case UserProfileQuizzSection.documentNumberAndCountry:
        _documentNumber = null;
        _documentCountry = null;

      case _:
        break;
    }

    jumpToNextSection();
  }

  void resetSection() {
    _currentQuizzSection = UserProfileQuizzSection.values.first;
    notifyListeners();
  }

  void previousSection() {
    const sections = UserProfileQuizzSection.values;
    final currentIndex = sections.indexOf(_currentQuizzSection);

    if (currentIndex == 0) return;

    _currentQuizzSection = sections[currentIndex - 1];
    notifyListeners();
  }

  void jumpToNextSection() {
    const sections = UserProfileQuizzSection.values;
    final currentIndex = sections.indexOf(_currentQuizzSection);

    if (currentIndex == sections.length - 1) return;

    _currentQuizzSection = sections[currentIndex + 1];

    notifyListeners();
  }

  void resetState() {
    _profilePhotoController.reset();
    _cardPhotoController.reset();
    _currentQuizzSection = UserProfileQuizzSection.documentType;
    _documentType = null;
    _documentNumber = null;
    _documentCountry = null;
    _pickedPhoto = null;
    _isProfilePhotoReady = false;
    _isCardPhotoReady = false;
    notifyListeners();
  }
}
