import 'package:get/get.dart';

class MyTranslation extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      //主页
      'title': '21Days',
      'doing': 'doing',
      'all': 'all',
      'mine': 'mine',
      // 新建页
      'newTodo': 'new todo',
      'todoName':'name',
      'startDate': 'startDate',
      'endDate': 'endDate',
      'add': 'add',
      // 我的页
      'changeTheme': 'change theme',
      'testData': 'testData',
      'delete': 'delete',
      'deleteSuc': 'Delete Success',
      'deleteFail': 'Delete Failed'
    },
    'zh_CN': {
      //主页
      'title': '21天',
      'doing': '进行中',
      'all': '所有',
      'mine': '我的',
      // 新建页
      'newTodo': '新建习惯',
      'todoName': '名字',
      'startDate': '开始日期',
      'endDate': '结束日期',
      'add': '添加',
      // 我的页
      'changeTheme': '主题选择',
      'testData': '测试数据',
      'delete': '删除',
      'deleteSuc': '删除成功',
      'deleteFail': '删除失败'
    }
  };

}