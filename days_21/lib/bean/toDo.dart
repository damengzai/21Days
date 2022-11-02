class ToDo {
  int id; // 主键
  int timeStamp;
  String name = "";

  ToDo({this.id = 1 ,this.name = 'name', this.timeStamp = 0});

  factory ToDo.fromJson(Map json) {
    return ToDo(id: json['id'], timeStamp: json['timeStamp'], name: json['name']);
  }

  Map toJson() {
    Map map = Map();
    map['id'] = id;
    map['timeStamp'] = timeStamp;
    map['name'] = name;
    return map;
  }
}
