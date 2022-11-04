class ToDo {
  int id; // 主键
  int timeStamp;
  String name = "";
  String startDate; // 开始日期
  String endDate; // 结束日期
  String clickDate; // 打开到的日期
  int status; // 当前状态 0:未知，1:完成，2:进行中，
  int type; // 类型0:未知 1:正常打卡， 2:反向打卡(不抱怨的世界)

  ToDo({
    this.id = 1,
    this.name = 'name',
    this.timeStamp = 0,
    this.startDate = '',
    this.endDate = '',
    this.clickDate = '',
    this.status = 0,
    this.type = 0,
  });

  factory ToDo.fromJson(Map json) {
    return ToDo(
      id: json['id']??0,
      timeStamp: json['timeStamp']??0,
      name: json['name']??'',
      startDate: json['startDate']??'',
      endDate: json['endDate']??'',
      clickDate: json['clickDate']??'',
      status: json['status']??0,
      type: json['type']??0,
    );
  }

  Map toJson() {
    Map map = Map();
    map['id'] = id;
    map['timeStamp'] = timeStamp;
    map['name'] = name;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['clickDate'] = clickDate;
    map['status'] = status;
    map['type'] = type;
    return map;
  }
}
