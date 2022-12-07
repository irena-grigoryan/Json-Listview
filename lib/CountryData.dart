List<String> names = [
  'Georgia',
  'Spain',
  'Ukraine',
  'Finland',
  'Poland',
];

List<String> url = [
  'https://www.countries-ofthe-world.com/flags-normal/flag-of-Georgia.png',
  'https://www.countries-ofthe-world.com/flags-normal/flag-of-Spain.png',
  'https://www.countries-ofthe-world.com/flags-normal/flag-of-Ukraine.png',
  'https://www.countries-ofthe-world.com/flags-normal/flag-of-Finland.png',
  'https://www.countries-ofthe-world.com/flags-normal/flag-of-Poland.png',
];

class CountryData {
  final String names, ImageUrl;
  CountryData(this.names, this.ImageUrl);
}

final List<CountryData> countryData = List.generate(
    names.length, (index) => CountryData('${names[index]}', '${url[index]}'));
