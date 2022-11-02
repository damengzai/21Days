class ToDo {
  int timeStamp;
  String name = "";

  ToDo({this.name = 'name', this.timeStamp = 0});

  factory ToDo.fromJson(Map json) {
    return ToDo(timeStamp: json['timeStamp'], name: json['name']);
  }

  Map toJson() {
    Map map = Map();
    map['timeStamp'] = timeStamp;
    map['name'] = name;
    return map;
  }
}
