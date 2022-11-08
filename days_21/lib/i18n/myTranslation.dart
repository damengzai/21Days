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
      'clickSuc': 'Click Success',
      'clickFail': 'Click Fail',
      'hasClicked': 'hasClicked',
      'unClick': 'unClick',
      // 新建页
      'newTodo': 'new todo',
      'todoName':'name',
      'startDate': 'startDate',
      'endDate': 'endDate',
      'add': 'add',
      'revertClick': 'revertClick',
      'whatsRevertClick':'what`s RevertClick',
      'addSuc':'Add Success',
      'addFail': 'Add Failed',
      'nameNotEmpty': 'Name Not Empty',
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
      'clickSuc': '打卡成功',
      'clickFail': '打卡失败',
      'hasClicked': '今日已打卡',
      'unClick': '今日未打卡',
      // 新建页
      'newTodo': '新建习惯',
      'todoName': '名字',
      'startDate': '开始日期',
      'endDate': '结束日期',
      'add': '添加',
      'revertClick': '反向打卡',
      'whatsRevertClick':'    什么是反向打卡，即不用每天主动打卡，系统会自动打卡，只有失败的时候才需要来点击放弃，类似"不抱怨的世界"',
      'addSuc':'添加成功',
      'addFail': '添加失败',
      'nameNotEmpty': '名字不可为空',
      // 我的页
      'changeTheme': '主题选择',
      'testData': '测试数据',
      'delete': '删除',
      'deleteSuc': '删除成功',
      'deleteFail': '删除失败'
    }
  };

}