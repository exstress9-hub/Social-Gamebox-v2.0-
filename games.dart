import 'package:flutter/material.dart';
import 'i18n.dart';

String L(String tr, String ru) => lang.value == 'ru' ? ru : tr;
final roster = <String>[];

class Game {
  final String id, name, emoji, cat, kind, dTr, dRu;
  final int min;
  final bool hotspot;
  const Game(this.id, this.name, this.emoji, this.cat, this.kind, this.min, this.dTr, this.dRu, {this.hotspot = false});
  String get desc => L(dTr, dRu);
}

const catColor = {
  'deduction': Color(0xFF7C4DFF),
  'party': Color(0xFFFF4081),
  'date': Color(0xFF448AFF),
  'classic': Color(0xFFFF9100),
};
const catName = {
  'deduction': ['Sosyal Çıkarım', 'Социальная дедукция'],
  'party': ['Parti', 'Вечеринка'],
  'date': ['Çiftler', 'Для двоих'],
  'classic': ['Oyun Gecesi', 'Игровой вечер'],
};

const games = <Game>[
  Game('impostor', 'Impostor', '🕵️', 'deduction', 'role', 3, 'Herkes aynı kelimeyi bilir, biri hariç', 'Все знают слово, кроме одного', hotspot: true),
  Game('timer', 'Timer Impostor', '⏱️', 'deduction', 'role', 3, 'Herkes aynı süreyi bilir, biri hariç', 'Все знают время, кроме одного'),
  Game('werewolf', 'Werewolf', '🐺', 'deduction', 'role', 5, 'Kurtları gece bitmeden bul', 'Найди волков до рассвета'),
  Game('mafia', 'Mafia', '🎩', 'deduction', 'role', 5, 'Mafyayı oylayarak bul', 'Найди мафию голосованием'),
  Game('murder', 'Murder', '🔪', 'deduction', 'role', 4, 'Katili bul', 'Найди убийцу'),
  Game('fakestory', 'Fake Story', '📖', 'deduction', 'role', 3, 'Biri hikâyeyi uyduruyor, kim?', 'Кто выдумывает историю?'),
  Game('fakeit', 'Fake It', '🎭', 'deduction', 'soon', 3, 'Yakında', 'Скоро'),
  Game('factfiction', 'Fact or Fiction', '🧐', 'deduction', 'soon', 3, 'Yakında', 'Скоро'),
  Game('tod', 'Truth or Dare', '🎯', 'party', 'deck', 2, 'Doğruluk mu cesaret mi?', 'Правда или действие?'),
  Game('never', 'Never Have I Ever', '🙈', 'party', 'deck', 2, 'Hiç yapmadım...', 'Я никогда не...'),
  Game('likely', "Who's Most Likely", '👆', 'party', 'deck', 3, 'Kim daha olası? Hep birlikte göster', 'Кто скорее всего? Показываем разом'),
  Game('wyr', 'Would You Rather', '⚖️', 'party', 'deck', 2, 'Hangisini seçerdin?', 'Что бы ты выбрал(а)?'),
  Game('hotbomb', 'Hot Bomb', '💣', 'party', 'bomb', 3, 'Kategoriden kelime söyle, bombayı geçir', 'Назови слово и передай бомбу'),
  Game('duel', 'Hot Bomb Duel', '🥊', 'party', 'bomb', 2, 'İki kişilik Hot Bomb', 'Hot Bomb на двоих'),
  Game('opposites', 'Opposites Day', '🙃', 'party', 'deck', 2, 'Sadece yanlış cevap ver', 'Отвечай наоборот'),
  Game('tilt', 'Tilt It', '📱', 'party', 'word', 3, 'Telefon alnında, ekibin anlatsın', 'Телефон на лбу, друзья объясняют'),
  Game('twit', 'Twit', '🐦', 'party', 'soon', 3, 'Yakında', 'Скоро'),
  Game('touchdown', 'Touchdown', '🏈', 'party', 'soon', 3, 'Yakında', 'Скоро'),
  Game('twenty', '\$20 Challenge', '💵', 'party', 'soon', 3, 'Yakında', 'Скоро'),
  Game('reverse', 'Reverse Singing', '🎤', 'party', 'soon', 2, 'Yakında', 'Скоро'),
  Game('qupid', 'Qupid', '💘', 'date', 'deck', 2, 'Çiftler için sorular', 'Вопросы для пар'),
  Game('love', 'Questions for Love', '💌', 'date', 'deck', 2, 'Birbirinizi daha iyi tanıyın', 'Узнайте друг друга лучше'),
  Game('aorb', 'A or B', '🅰️', 'date', 'deck', 2, 'A mı B mi?', 'А или Б?'),
  Game('charades', 'Charades', '🎬', 'classic', 'word', 3, 'Kelimeyi hareketle anlat', 'Покажи слово жестами'),
  Game('whoami', 'Who Am I', '❓', 'classic', 'word', 3, 'Evet/hayır soruları ile kim olduğunu bul', 'Угадай, кто ты, вопросами'),
  Game('comedygod', 'Comedy God', '😂', 'classic', 'soon', 3, 'Yakında', 'Скоро'),
  Game('tentangle', 'Ten Tangle', '🔟', 'classic', 'soon', 3, 'Yakında', 'Скоро'),
  Game('wrong', 'Wrong Answers Only', '❌', 'classic', 'deck', 2, 'Sadece yanlış cevaplar!', 'Только неправильные ответы!'),
];

List<String> words() => lang.value == 'ru' ? _wRu : _wTr;
List<String> bombCats() => lang.value == 'ru' ? _bRu : _bTr;
const _wTr = ['Deve', 'Halı', 'Çay', 'Okul', 'Doktor', 'Deniz', 'Kervan', 'Pilav', 'Futbol', 'Ay', 'Saat', 'Aslan', 'Pilot', 'Telefon', 'Kedi', 'Dondurma'];
const _wRu = ['Верблюд', 'Ковёр', 'Чай', 'Школа', 'Врач', 'Море', 'Караван', 'Плов', 'Футбол', 'Луна', 'Часы', 'Лев', 'Пилот', 'Телефон', 'Кошка', 'Мороженое'];
const _bTr = ['Hayvanlar', 'Meyveler', 'Şehirler', 'Ülkeler', 'Renkler', 'Yiyecekler'];
const _bRu = ['Животные', 'Фрукты', 'Города', 'Страны', 'Цвета', 'Еда'];

const roles = {
  'wolf': ['Kurt', 'Волк'], 'villager': ['Köylü', 'Мирный житель'], 'seer': ['Kâhin', 'Провидец'], 'doctor': ['Doktor', 'Доктор'],
  'mafia': ['Mafya', 'Мафия'], 'citizen': ['Vatandaş', 'Мирный житель'], 'cop': ['Komiser', 'Комиссар'],
  'killer': ['Katil', 'Убийца'], 'detective': ['Dedektif', 'Детектив'], 'innocent': ['Masum', 'Невиновный'],
};

// Her oyuna ait içerik: [Türkçe, Русский]
const decks = <String, List<List<String>>>{
  'truth': [
    ['En son ne zaman yalan söyledin?', 'Bu odada en çok kime güveniyorsun?', 'Kimseye söylemediğin bir sırrın ne?', 'Seni en çok utandıran an hangisiydi?', 'Telefonundaki son fotoğraf ne?'],
    ['Когда ты последний раз врал(а)?', 'Кому в этой комнате ты доверяешь больше всех?', 'Какой секрет ты никому не рассказывал(а)?', 'Какой момент тебя больше всего смутил?', 'Что на последнем фото в твоём телефоне?'],
  ],
  'dare': [
    ['Deve gibi yürü, 30 saniye.', 'Yanındaki kişiye iltifat et.', 'Gülmeden 20 saniye şarkı söyle.', 'Sağındaki kişiyi taklit et.', 'Bir dakika sadece fısıldayarak konuş.'],
    ['Ходи как верблюд 30 секунд.', 'Сделай комплимент соседу.', 'Пой 20 секунд, не смеясь.', 'Изобрази человека справа.', 'Минуту говори только шёпотом.'],
  ],
  'never': [
    ['Hiç otobüste uyuyakalmadım.', 'Hiç yanlış kişiye mesaj atmadım.', 'Hiç derste uyumadım.', 'Hiç yemeği yakmadım.', 'Hiç alarmı duymadan uyumadım.'],
    ['Я никогда не засыпал(а) в автобусе.', 'Я никогда не писал(а) не тому человеку.', 'Я никогда не спал(а) на уроке.', 'Я никогда не сжигал(а) еду.', 'Я никогда не просыпал(а) будильник.'],
  ],
  'likely': [
    ['Kim en çok geç kalır?', 'Kim piyangoyu kazanıp hepsini harcar?', 'Kim en çok yemek yer?', 'Kim bir gecede ünlü olur?', 'Kim telefonunu en sık kaybeder?'],
    ['Кто чаще всех опаздывает?', 'Кто выиграет в лотерею и всё потратит?', 'Кто съест больше всех?', 'Кто станет знаменитым за ночь?', 'Кто чаще всех теряет телефон?'],
  ],
  'wyr': [
    ['Hep sıcak mı, hep soğuk mu?', 'Uçmak mı, görünmez olmak mı?', 'Bir hafta telefonsuz mu, çaysız mı?', 'Geçmişe mi, geleceğe mi gitmek?', 'Zengin ama yalnız mı, fakir ama mutlu mu?'],
    ['Всегда жара или всегда холод?', 'Летать или быть невидимым?', 'Неделя без телефона или без чая?', 'В прошлое или в будущее?', 'Богатый, но одинокий или бедный, но счастливый?'],
  ],
  'aorb': [
    ['Çay mı, kahve mi?', 'Deniz mi, dağ mı?', 'Sabah mı, gece mi?', 'Pilav mı, makarna mı?', 'Film mi, kitap mı?'],
    ['Чай или кофе?', 'Море или горы?', 'Утро или ночь?', 'Плов или паста?', 'Фильм или книга?'],
  ],
  'love': [
    ['Beni ilk fark ettiğinde ne düşündün?', 'Birlikte en sevdiğin anımız hangisi?', 'Beni en çok ne güldürür?', 'Gelecekte nerede yaşamak isterdin?', 'Bende en çok neyi takdir ediyorsun?'],
    ['О чём ты думал(а), когда впервые меня заметил(а)?', 'Какой наш любимый момент?', 'Что тебя во мне смешит больше всего?', 'Где бы ты хотел(а) жить в будущем?', 'Что ты во мне ценишь больше всего?'],
  ],
  'qupid': [
    ['Mükemmel buluşma nasıl olurdu?', 'Benden öğrendiğin en önemli şey?', 'Beni üç kelimeyle anlat.', 'Birlikte ne denemek isterdin?', 'Seni en çok ne mutlu eder?'],
    ['Каким было бы идеальное свидание?', 'Чему главному ты у меня научился(лась)?', 'Опиши меня тремя словами.', 'Что бы ты хотел(а) попробовать вместе?', 'Что делает тебя самым счастливым?'],
  ],
  'wrong': [
    ['En büyük hayvan hangisi?', 'Haftanın ilk günü hangisi?', 'Su kaç derecede kaynar?', 'Güneş nereden doğar?', 'Bir yıl kaç aydır?'],
    ['Какое самое большое животное?', 'Какой первый день недели?', 'При какой температуре кипит вода?', 'Откуда встаёт солнце?', 'Сколько месяцев в году?'],
  ],
  'opposites': [
    ['Adını söyle.', 'Hava nasıl?', 'Kaç yaşındasın?', 'Bugün hangi gün?', 'Ne renk giyiyorsun?'],
    ['Назови своё имя.', 'Какая погода?', 'Сколько тебе лет?', 'Какой сегодня день?', 'Какого цвета твоя одежда?'],
  ],
};
