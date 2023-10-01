getDataAndFillterIt({required Map dataMap, required String majles}) {
  var getQuery = [];
  for (int i = 0; i < dataMap.length; i++) {
    if (dataMap[i][majles] == majles) {
      getQuery.add(dataMap[i]);
    }
  }
  return getQuery;
}
