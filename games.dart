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
  Game('fakeit', 'Fake It', '🎭', 'deduction', 'role', 3, 'Soruyu bilmeyen biri cevabı uydurur', 'Один не знает вопрос и блефует'),
  Game('factfiction', 'Fact or Fiction', '🧐', 'deduction', 'deck', 2, 'Doğru mu uydurma mı?', 'Правда или вымысел?'),
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
  Game('reverse', 'Reverse Singing', '🎤', 'party', 'deck', 2, 'Cümleyi kelime sırasını tersine çevirerek söyle', 'Скажи фразу, поменяв порядок слов'),
  Game('quicktap', 'Quick Tap', '⚡', 'party', 'tap', 2, 'Yeşil olunca ilk basan kazanır', 'Кто первым нажмёт на зелёный'),
  Game('qupid', 'Qupid', '💘', 'date', 'deck', 2, 'Çiftler için sorular', 'Вопросы для пар'),
  Game('love', 'Questions for Love', '💌', 'date', 'deck', 2, 'Birbirinizi daha iyi tanıyın', 'Узнайте друг друга лучше'),
  Game('aorb', 'A or B', '🅰️', 'date', 'deck', 2, 'A mı B mi?', 'А или Б?'),
  Game('charades', 'Charades', '🎬', 'classic', 'word', 3, 'Kelimeyi hareketle anlat', 'Покажи слово жестами'),
  Game('whoami', 'Who Am I', '❓', 'classic', 'word', 3, 'Evet/hayır soruları ile kim olduğunu bul', 'Угадай, кто ты, вопросами'),
  Game('comedygod', 'Comedy God', '😂', 'classic', 'soon', 3, 'Yakında', 'Скоро'),
  Game('tentangle', 'Ten Tangle', '🔟', 'classic', 'soon', 3, 'Yakında', 'Скоро'),
  Game('wrong', 'Wrong Answers Only', '❌', 'classic', 'deck', 2, 'Sadece yanlış cevaplar!', 'Только неправильные ответы!'),
];

List<String> words() => lang.value == 'ru' ? [..._wRu, ..._wRu2] : [..._wTr, ..._wTr2];
List<String> bombCats() => lang.value == 'ru' ? [..._bRu, ..._bRu2] : [..._bTr, ..._bTr2];
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

List<String> deckItems(String k) {
  final i = lang.value == 'ru' ? 1 : 0;
  return [...(decks[k]?[i] ?? const <String>[]), ...(more[k]?[i] ?? const <String>[])];
}

const _wTr2 = ['Kuş', 'Araba', 'Balık', 'Ağaç', 'Yağmur', 'Kitap', 'Ayakkabı', 'Kapı', 'Pizza', 'Gitar', 'Uçak', 'Bisiklet', 'Kar', 'Çiçek', 'Ekmek', 'Kral'];
const _wRu2 = ['Птица', 'Машина', 'Рыба', 'Дерево', 'Дождь', 'Книга', 'Обувь', 'Дверь', 'Пицца', 'Гитара', 'Самолёт', 'Велосипед', 'Снег', 'Цветок', 'Хлеб', 'Король'];
const _bTr2 = ['Meslekler', 'Sporlar', 'Sebzeler', 'Mutfak eşyaları', 'Erkek isimleri', 'Kız isimleri'];
const _bRu2 = ['Профессии', 'Виды спорта', 'Овощи', 'Кухонные предметы', 'Мужские имена', 'Женские имена'];

// Ek içerik: [Türkçe, Русский]
const more = <String, List<List<String>>>{
  'truth': [
    ['Hayatında yaptığın en çılgın şey ne?', 'Kimseye söylemediğin bir korkun ne?', 'Bu odadaki kimle bir gün yer değiştirmek isterdin?', 'En son ne zaman ağladın ve neden?', 'Hangi alışkanlığından vazgeçemiyorsun?', 'Çocukken yaptığın en büyük yaramazlık neydi?', 'Gizlice en çok neye hayransın?'],
    ['Что самое безумное ты делал(а) в жизни?', 'Чего ты боишься, но никому не говоришь?', 'С кем из присутствующих ты бы поменялся(лась) на день?', 'Когда ты последний раз плакал(а) и почему?', 'От какой привычки ты не можешь отказаться?', 'Какая была твоя самая большая детская шалость?', 'Чем ты тайно восхищаешься?'],
  ],
  'dare': [
    ['Bir hayvan sesi çıkar, herkes tahmin etsin.', 'Bir dakika boyunca robot gibi konuş.', 'En komik yüz ifadeni yap ve 10 saniye tut.', 'Bir ürün için komik bir reklam yap.', 'Müziksiz 15 saniye dans et.', 'Sağındaki kişiye bir şiir uydur.', 'Bir dakika boyunca her cümleyi soruyla bitir.'],
    ['Издай звук животного, пусть угадают.', 'Минуту говори как робот.', 'Сделай самую смешную гримасу и держи 10 секунд.', 'Сделай смешную рекламу любого предмета.', 'Танцуй 15 секунд без музыки.', 'Придумай стихотворение для соседа справа.', 'Минуту заканчивай каждую фразу вопросом.'],
  ],
  'never': [
    ['Hiç parkta uyuyakalmadım.', 'Hiç bir filmde ağlamadım.', 'Hiç kendi kendime konuşmadım.', 'Hiç yanlış otobüse binmedim.', 'Hiç çayı dökmedim.', 'Hiç saklambaçta uyuyakalmadım.', 'Hiç telefonumu bir yerde unutmadım.'],
    ['Я никогда не засыпал(а) в парке.', 'Я никогда не плакал(а) на фильме.', 'Я никогда не разговаривал(а) сам с собой.', 'Я никогда не садился(лась) не в тот автобус.', 'Я никогда не проливал(а) чай.', 'Я никогда не засыпал(а) в прятках.', 'Я никогда не забывал(а) телефон где-то.'],
  ],
  'likely': [
    ['Kim ilk önce evlenir?', 'Kim bir yolculukta kaybolur?', 'Kim en iyi aşçı olur?', 'Kim yarın sabah ilk uyanır?', 'Kim en çok selfie çeker?', 'Kim bir sırrı saklayamaz?', 'Kim en iyi lider olur?'],
    ['Кто первым женится или выйдет замуж?', 'Кто заблудится в поездке?', 'Кто лучший повар?', 'Кто проснётся первым?', 'Кто делает больше всех селфи?', 'Кто не умеет хранить секреты?', 'Кто станет лучшим лидером?'],
  ],
  'wyr': [
    ['Her gün pilav mı, her gün makarna mı?', 'Hayvanlarla konuşmak mı, her dili bilmek mi?', 'Çok erken kalkmak mı, çok geç yatmak mı?', 'Hiç tatil yapmamak mı, hiç hafta sonu olmamak mı?', 'Zamanı durdurmak mı, zihin okumak mı?', 'Ünlü olmak mı, çok zengin olmak mı?', 'Hep doğruyu söylemek mi, hep yalan mı?'],
    ['Каждый день плов или каждый день паста?', 'Говорить с животными или знать все языки?', 'Вставать очень рано или ложиться очень поздно?', 'Никогда не отдыхать или без выходных?', 'Останавливать время или читать мысли?', 'Быть знаменитым или очень богатым?', 'Всегда говорить правду или всегда лгать?'],
  ],
  'aorb': [
    ['Kış mı, yaz mı?', 'Kedi mi, köpek mi?', 'Tatlı mı, tuzlu mu?', 'Şehir mi, köy mü?', 'Telefon mu, bilgisayar mı?', 'Futbol mu, basketbol mu?', 'Yalnız mı, kalabalık mı?'],
    ['Зима или лето?', 'Кошка или собака?', 'Сладкое или солёное?', 'Город или деревня?', 'Телефон или компьютер?', 'Футбол или баскетбол?', 'Одному или в компании?'],
  ],
  'love': [
    ['Birlikte yapmak istediğin bir yolculuk?', 'Seni en çok neyle şaşırtabilirim?', 'Beni ilk gördüğünde ne hissettin?', 'Bende seni ne güldürür?', 'Yaşlandığımızda ne yapıyor olalım?', 'Sana en çok hangi sözüm dokundu?', 'Sence bizi özel yapan ne?'],
    ['Какое путешествие ты хочешь вместе?', 'Чем я могу тебя удивить?', 'Что ты почувствовал(а), когда впервые меня увидел(а)?', 'Что во мне тебя смешит?', 'Чем мы займёмся, когда состаримся?', 'Какие мои слова тронули тебя больше всего?', 'Что, по-твоему, делает нас особенными?'],
  ],
  'qupid': [
    ['Hayalindeki ortak ev nasıl olurdu?', 'Bir kavgadan sonra nasıl barışırsın?', 'Aşkı bir kelimeyle anlat.', 'Beni hangi şarkıyla anarsın?', 'Birlikte en çok neyi özledin?', 'Senin için güven ne demek?', 'Bir günümüz bomboş olsa ne yapardık?'],
    ['Каким был бы наш общий дом?', 'Как ты миришься после ссоры?', 'Опиши любовь одним словом.', 'С какой песней ты ассоциируешь меня?', 'По чему ты скучаешь больше всего?', 'Что для тебя значит доверие?', 'Что бы мы сделали, если бы у нас был целый свободный день?'],
  ],
  'wrong': [
    ['İki artı iki kaçtır?', 'Aşkabat hangi ülkenin başkentidir?', 'Bir saat kaç dakikadır?', 'Gökyüzü ne renktir?', 'Kuşlar ne ile uçar?', 'Haftada kaç gün var?', 'Karpuzun içi ne renktir?'],
    ['Сколько будет два плюс два?', 'Столицей какой страны является Ашхабад?', 'Сколько минут в часе?', 'Какого цвета небо?', 'Чем летают птицы?', 'Сколько дней в неделе?', 'Какого цвета арбуз внутри?'],
  ],
  'opposites': [
    ['Ne yapıyorsun?', 'Nerede yaşıyorsun?', 'Ne yemek istersin?', 'Kaçta uyanırsın?', 'En sevdiğin renk ne?', 'Bugün nasılsın?', 'Kiminle geldin?'],
    ['Что ты делаешь?', 'Где ты живёшь?', 'Что хочешь съесть?', 'Во сколько просыпаешься?', 'Какой твой любимый цвет?', 'Как ты сегодня?', 'С кем ты пришёл?'],
  ],
  'factfiction': [
    ['Güneş bir yıldızdır.||Doğru', 'Yarasalar kördür.||Yanlış, iyi görürler', 'Bal yıllarca bozulmadan durabilir.||Doğru', 'Salyangozların dişi yoktur.||Yanlış, binlerce küçük dişleri var', 'Yetişkin insanda 206 kemik vardır.||Doğru', 'Altın suda paslanır.||Yanlış, altın paslanmaz', 'Şimşek aynı yere iki kez düşebilir.||Doğru', 'Deve hörgücünde su depolar.||Yanlış, yağ depolar'],
    ['Солнце — это звезда.||Правда', 'Летучие мыши слепые.||Ложь, они хорошо видят', 'Мёд может храниться годами.||Правда', 'У улиток нет зубов.||Ложь, у них тысячи мелких зубов', 'У взрослого человека 206 костей.||Правда', 'Золото ржавеет в воде.||Ложь, золото не ржавеет', 'Молния может ударить в одно место дважды.||Правда', 'Верблюд хранит воду в горбу.||Ложь, он хранит жир'],
  ],
  'fakeit': [
    ['En sevdiğin yemek ne?', 'Tatilde nereye gitmek istersin?', 'Çocukken ne olmak istiyordun?', 'Bir günün nasıl geçer?', 'En çok neyden korkarsın?', 'Hafta sonu ne yaparsın?'],
    ['Какая твоя любимая еда?', 'Куда бы ты поехал(а) в отпуск?', 'Кем ты хотел(а) стать в детстве?', 'Как проходит твой день?', 'Чего ты боишься больше всего?', 'Что ты делаешь на выходных?'],
  ],
  'reverse': [
    ['Bugün hava çok güzel', 'Çay demlemek bir sanattır', 'Kervan yolda düzülür', 'Her şey çok güzel olacak', 'Deve gibi sabırlı ol', 'Kitap okumak insanı büyütür', 'Güneş doğudan doğar', 'Arkadaşlar bir araya geldi', 'Yarın erkenden uyanacağım', 'Pilav yapmayı çok severim'],
    ['Сегодня очень хорошая погода', 'Заваривать чай это искусство', 'Тише едешь дальше будешь', 'Всё будет очень хорошо', 'Будь терпелив как верблюд', 'Чтение делает человека лучше', 'Солнце встаёт на востоке', 'Друзья собрались вместе', 'Завтра я проснусь рано', 'Я очень люблю готовить плов'],
  ],
};
