class MovieData{
  //Manter todos como String e fazer a conversão(se necessário) quando instanciar dados nos Cards
  final int id;
  final String title;
  final String bannerPath;
  final String rating;
  final String lauchYear;
  final String credits;

  MovieData({
    required this.id,
    required this.title,
    required this.bannerPath,
    required this.rating,
    required this.lauchYear,
    required this.credits
  });

  factory MovieData.fromJson(Map<String, dynamic> json){
    return MovieData(
      id: json['id'],
      title: json['title'],
      bannerPath: json['image_url'],
      rating: json['rating'],
      lauchYear: json['year'],
      credits: json['crew']
    );
  }
}