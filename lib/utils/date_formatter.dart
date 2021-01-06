class DateFormatter {
  String toDatabase(String date) {
    List<String> dateSplit = date.split('/');
    return dateSplit[2] + '-' + dateSplit[1] + '-' + dateSplit[0];
  }

  String fromDatabase(String date) {
    List<String> dateSplit = date.split('-');
    return dateSplit[2] + '/' + dateSplit[1] + '/' + dateSplit[0];
  }
}
