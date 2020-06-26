class Note {

  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;
  // ignore: non_constant_identifier_names
  int _is_delete;

  Note(this._title, this._date, this._priority,this._is_delete, [this._description]);

  Note.withId(this._id, this._title, this._date, this._priority,this._is_delete, [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  int get priority => _priority;

  String get date => _date;
  // ignore: non_constant_identifier_names
  int get is_delete => _is_delete;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }
  // ignore: non_constant_identifier_names
  set is_delete(int newDelete) {
    this._is_delete = newDelete;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    map['is_delete'] = _is_delete;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
    this._is_delete = map['is_delete'];
  }
}


