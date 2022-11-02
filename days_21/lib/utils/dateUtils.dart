//计算两个日期天数差
int diffDays(DateTime startDate,DateTime endDate) {
  return endDate.difference(startDate).inDays;
}
//计算日期与当前日期差
int diffDaysFormNow(DateTime startDate) {
  DateTime nowTime = DateTime.now();
  return nowTime.difference(startDate).inDays;
}