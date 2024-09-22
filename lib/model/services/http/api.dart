
enum RequestType {
  // ignore: constant_identifier_names
  Post,
  // ignore: constant_identifier_names
  Put,
  // ignore: constant_identifier_names
  Get,
  // ignore: constant_identifier_names
  Delete,
}

class Headers {
  static Map<String, String> get header => {
    "Accept": "application/json",
    "content-type": "application/json",
  };

}

class EndPoints {

  static const serverUrl="https://jsonplaceholder.typicode.com/";
  static const getPhotos="photos";
}
