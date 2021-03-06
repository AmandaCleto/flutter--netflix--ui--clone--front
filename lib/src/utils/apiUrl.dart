import '../config/config.dart';

String API_KEY = Config.getApiKey('API_KEY');

String apiBase = 'https://api.themoviedb.org/3/';
String apiKey = 'api_key=$API_KEY';
String language = '&language=pt-BR';
String discover = 'discover/';
String getMovie = 'movie?';
String movieDetail = 'movie/';
String topRated = 'top_rated?';

String apiCarouselUrl({required int page, required String type}) {
  if (type == 'popular') {
    return '$apiBase${movieDetail}popular?$apiKey$language&page=$page';
  }

  if (type == 'top_rated') {
    return '$apiBase/trending/${movieDetail}day?$apiKey$language';
  }

  if (type == 'now_playing') {
    return '$apiBase${movieDetail}now_playing?$apiKey$language&page=$page';
  }

  return 'Não foi possível retornar a URL da API';
}

String apiDeepUrl({required int id, required String type}) {
  if (type == 'detailed') {
    return '$apiBase$movieDetail$id?$apiKey$language';
  }

  if (type == 'credit') {
    return '$apiBase$movieDetail$id/credits?$apiKey$language';
  }

  return 'Não foi possível retornar a URL da API';
}

String apiRecommendationUrl({required int id}) {
  return '$apiBase$movieDetail$id/similar?$apiKey$language';
}
