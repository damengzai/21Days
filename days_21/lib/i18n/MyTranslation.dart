import 'package:get/get.dart';

class MyTransLation extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en': {
      'title': '21Days',
      // 新建页
      'newTodo': 'new todo',
      'todoName':'name',
      'startDate': 'startDate',
      'add': 'add'
    },
    'zh_CN': {
      'title': '21天',
      // 新建页
      'newTodo': '新建习惯',
      'todoName': '名字',
      'startDate': '开始日期',
      'add': '添加'
    }
  };

}