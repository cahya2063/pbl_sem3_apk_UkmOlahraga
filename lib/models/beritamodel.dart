class Api {
  String? sourceId;
  String? sourceName;
  String? author;
  String? title;
  String? url;
  String? published;

  Api({this.sourceId,this.sourceName, this.author, this.title, this.published, this.url});
  factory Api.createApi(Map<String, dynamic> objek) {
    return Api(
      sourceId: objek['source']['id'],
      sourceName: objek['source']['name'],
      author: objek['author'],
      title: objek['title'],
      url: objek['url'],
      published: objek['publishedAt'],
    );
  }
}
