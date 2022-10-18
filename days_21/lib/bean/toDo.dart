class ToDo {
  int timeStmp;
  String name = "";

  ToDo({this.name = 'name', this.timeStmp = 0});

  factory ToDo.fromJson(Map json) {
    return ToDo(timeStmp: json['timeStmp'], name: json['name']);
  }

  Map toJson() {
    Map map = Map();
    map['timeStmp'] = timeStmp;
    map['name'] = name;
    return map;
  }
}
