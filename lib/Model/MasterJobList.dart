class JobList {
  final String id;
  final String name;

  JobList({this.id, this.name});

  factory JobList.fromJson(Map<String, dynamic> json) {
    return JobList(
      id: json['id'],
      name: json['name'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;

    return map;
  }
}