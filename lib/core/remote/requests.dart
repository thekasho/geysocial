import '../class/crud.dart';

class Requests {
  Crud crud;

  Requests(this.crud);

  postData(Map data, dynamic linkurl) async {
    var response = await crud.postData(linkurl, data);
    return response.fold((l) => l, (r) => r);
  }

}