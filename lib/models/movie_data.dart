class MovieData{
  
  final String title;
  final String bannerPath;
  final String rating;
  final String launchYear;
  final String credits;

  MovieData({
    required this.title,
    required this.bannerPath,
    required this.rating,
    required this.launchYear,
    required this.credits
  });

  factory MovieData.fromJson(Map<String, dynamic> json){
    return MovieData(
      title: json['title'],
      bannerPath: json['image_url'],
      rating: json['rating'],
      launchYear: json['year'],
      credits: json['crew']
    );
  }
}