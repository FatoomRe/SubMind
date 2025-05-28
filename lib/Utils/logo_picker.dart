


String getLogoAsset(String name) {
  final lower = name.toLowerCase();
  if (lower.contains('spotify')) return 'assets/Logos/Spotify.svg';
  if (lower.contains('netflix')) return 'assets/Logos/Netflix.svg';
  if (lower.contains('youtube')) return 'assets/Logos/youtube.png';
  if (lower.contains('adobe')) return 'assets/Logos/AdobeLogo.webp';
  if (lower.contains('anghami')) return 'assets/Logos/AnghamiLogo.png';
  if (lower.contains('apple music')) return 'assets/Logos/ITunes.svg';
  if (lower.contains('crunchyroll')) return 'assets/Logos/Crunchyroll.webp';
  return 'assets/Logos/default.png';
}
