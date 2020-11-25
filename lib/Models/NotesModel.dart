class NotesModel {
  final String note;

  NotesModel(this.note);

  NotesModel.fromJson(json) : note = json['notes'];
}
