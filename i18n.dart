import 'package:flutter/material.dart';

final lang = ValueNotifier<String>('tr');
String t(String k) => (lang.value == 'ru' ? _ru : _tr)[k] ?? k;

class Cat {
  final String id;
  final IconData icon;
  final List<String> games;
  const Cat(this.id, this.icon, this.games);
}

const cats = [
  Cat('cat1', Icons.visibility_off, ['impostor', 'werewolf', 'spy']),
  Cat('cat2', Icons.theater_comedy, ['charades', 'whoami', 'taboo', 'draw']),
  Cat('cat3', Icons.emoji_emotions, ['wrong', 'caption', 'story']),
  Cat('cat4', Icons.bolt, ['buzzer', 'quiz', 'tf']),
  Cat('cat5', Icons.forum, ['never', 'likely', 'tod']),
];

// Oynanabilir modlar (diğerleri "Yakında")
const playable = {'impostor'};

const trWords = <String>['Elma', 'Deve', 'Halı', 'Çay', 'Okul', 'Doktor', 'Deniz', 'Kervan', 'Pilav', 'Futbol', 'Ay', 'Saat'];
const ruWords = <String>['Яблоко', 'Верблюд', 'Ковёр', 'Чай', 'Школа', 'Врач', 'Море', 'Караван', 'Плов', 'Футбол', 'Луна', 'Часы'];

const _tr = <String, String>{
  'sub': 'Hotspot ile parti oyunları',
  'name': 'Adın',
  'join': 'Oyuna katıl',
  'tap': 'Oda açmak için bir oyun seç',
  'cat1': 'Gizli Roller',
  'cat2': 'Anlat ve Tahmin Et',
  'cat3': 'Komik ve Yaratıcı',
  'cat4': 'Hız ve Bilgi',
  'cat5': 'Sohbet ve Yakınlaşma',
  'impostor': 'Impostor',
  'werewolf': 'Werewolf',
  'spy': 'Casus Mekân',
  'charades': 'Charades',
  'whoami': 'Who Am I',
  'taboo': 'Yasak Kelime',
  'draw': 'Çiz Bakalım',
  'wrong': 'Sadece Yanlış Cevaplar',
  'caption': 'Altyazı Savaşı',
  'story': 'Hikâye Zinciri',
  'buzzer': 'Hızlı Parmak',
  'quiz': 'Bilgi Yarışı',
  'tf': 'Doğru mu Yanlış mı',
  'never': 'Hiç Yapmadım',
  'likely': 'Kim Daha Olası',
  'tod': 'Doğruluk mu Cesaret mi',
  'soon': 'Yakında',
  'players': 'Oyuncular',
  'start': 'Başlat',
  'need3': 'En az 3 oyuncu gerekli',
  'ipinfo': 'Arkadaşların «Oyuna katıl» tuşuna bassın. Bulamazsa IP: ',
  'searching': 'Yakındaki odalar aranıyor…',
  'manual': 'IP ile bağlan',
  'connect': 'Bağlan',
  'waiting': 'Host oyunu başlatınca burada görünecek',
  'hold': 'Kartı görmek için basılı tut',
  'impWord': 'SEN IMPOSTORSUN! Kelimeyi bilmiyorsun.',
  'word': 'Kelime',
  'fail': 'Bağlanılamadı',
  'back': 'Geri',
};

const _ru = <String, String>{
  'sub': 'Парти-игры по хотспоту',
  'name': 'Твоё имя',
  'join': 'Присоединиться',
  'tap': 'Выбери игру, чтобы открыть комнату',
  'cat1': 'Секретные роли',
  'cat2': 'Объясни и угадай',
  'cat3': 'Весёлые и творческие',
  'cat4': 'Скорость и знания',
  'cat5': 'Общение',
  'impostor': 'Impostor',
  'werewolf': 'Werewolf',
  'spy': 'Шпион',
  'charades': 'Charades',
  'whoami': 'Who Am I',
  'taboo': 'Запретные слова',
  'draw': 'Рисуй и угадывай',
  'wrong': 'Только неправильные ответы',
  'caption': 'Битва подписей',
  'story': 'Цепочка историй',
  'buzzer': 'Быстрый палец',
  'quiz': 'Викторина',
  'tf': 'Правда или ложь',
  'never': 'Я никогда не',
  'likely': 'Кто скорее всего',
  'tod': 'Правда или действие',
  'soon': 'Скоро',
  'players': 'Игроки',
  'start': 'Начать',
  'need3': 'Нужно минимум 3 игрока',
  'ipinfo': 'Пусть друзья нажмут «Присоединиться». Если не найдут, IP: ',
  'searching': 'Ищем комнаты рядом…',
  'manual': 'Подключиться по IP',
  'connect': 'Подключиться',
  'waiting': 'Ждём, пока хост начнёт игру',
  'hold': 'Зажми, чтобы увидеть карту',
  'impWord': 'ТЫ ИМПОСТОР! Ты не знаешь слово.',
  'word': 'Слово',
  'fail': 'Не удалось подключиться',
  'back': 'Назад',
};
