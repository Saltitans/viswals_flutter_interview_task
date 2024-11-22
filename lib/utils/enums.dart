enum UserProfileQuizzSection {
  documentType,
  documentNumberAndCountry,
  photos,
}

enum DocumentType {
  passport('Passport'),
  nationalCard('National Card');

  const DocumentType(this.label);

  final String label;
}

enum PhotoPlanningSection {
  profile('Profile'),
  card('Card');

  const PhotoPlanningSection(this.label);

  final String label;
}
