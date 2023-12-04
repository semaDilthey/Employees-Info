# Employees-Info
fetch information from working API and represents it as a table with some features.
This is a test assignment. It represents a list of employees. MVVM architecture was used in its creation

## Prototype:  [FIGMA](https://www.figma.com/file/GRRKONipVClULsfdCAuVs1/KODE-Trainee-Dev-Осень'21?type=design&node-id=0-1&mode=design&t=p9mP9IAaAmq9azLu-0)
<details>
  <summary><b>What was done during the work process</b></summary>

* Decomposition
* Network operations (URLSession, JSON)
* Data transformation 
* Animation handling
* Custom views implementation
* Data search in an Array
* Sorting
* GCD
* 
</details>

## Done
The following tasks were completed:

1. The project was structured into stages, including decomposition, removal of storyboards, installation of necessary fonts.

2. NetworkManager was set up with API parsing, writing functions for data fetching, and creating a JSON data model.

3. Work on the MainViewController included creating a UITableView, configuring a SearchBar, and adding data sorting by name and surname. SkeletonView was set up for marked scenarios.

4. For the DetailsViewController, item selection, interface configuration, triggering an action on the lower label tap, and working with date formatter and phone number mask were configured.

5. An ErrorViewController screen was created with UI elements, a button to return to MainViewController, and an optional text block for displaying errors in case of no internet connection or API error.

6. Additionally, tasks such as implementing an animated custom pull-to-refresh indicator, creating a custom SearchField, configuring pagination, and handling unforeseen scenarios were completed.

 ## Presentation
  ### 1. Switching tabs and demonstrating pull-to-refresh AND Searching AND Sorting by name or birthday

![1  slides presentation](https://github.com/semaDilthey/Employees-Info/assets/128741166/d21933df-cefd-46ee-bdce-bb8092d90948), ![4  Searching](https://github.com/semaDilthey/Employees-Info/assets/128741166/a08017d7-dbaf-4c7f-ad4d-0325a01b4fdd) ,![3  sorting by name or birthday](https://github.com/semaDilthey/Employees-Info/assets/128741166/781cea46-600c-4269-87b8-0dd1ce303fe1)

 ### 2. Details screen and UIApplication functionality
 
![2  details screen and UIApplication functionality](https://github.com/semaDilthey/Employees-Info/assets/128741166/913bcf91-49fb-4e0b-8308-f551a50fe8f8)

### 3. App behavior when the internet connection is lost.

![5  When there is no internet connection](https://github.com/semaDilthey/Employees-Info/assets/128741166/fdd670db-b745-46ae-97f8-776fccd56cb5)

### 4. Complete demonstration

![6  Demonstration](https://github.com/semaDilthey/Employees-Info/assets/128741166/575c5f82-c9ea-4cee-b31a-84950ccad774)


## Декомпозиция
Первый опыт подробной разбивки. Нус, попробуем. Формат: Задача (Запланировано/Фактически) минут
### 1. Декомпозиция (60/ 51)

### 2. Настройка приложения (90/ 45):
  * 2.1 Удаление сториборба, отвязка связей, настройка sceneDelegate (30/ 7)
  * 2.2 Найти шрифты, установить их, написать экстеншены (40/ 24)
  * 2.3 Добавить UIColor's для проекта. Белый, Белый потемнее и фиолетовый проекта. (20/ 14)
    
### 3. Настройка сервисов (280/ 160):
  * 3.1 NetworkManager - разобраться с api, написать функции для фетчинга апи (60/ 50 )
  * 3.2 Создать модель данных JSON (20/ 15)
  * 3.3 Создать DataSource для работы с полученными данными, создание массива [Empoyees] распарсенной модели, создание енамов для работы с департаментом, создание функции для работы с датой рождения, создание функций для сортировки по: Фамилии, Дате рождения (80/ 35)
  * 3.4 Непредвиденные задачки (30/ 30)
  * 3.5 Найти способ создания комплишенХендлера, чтобы отображать информацию по мере загрузки. Типа .success, .loading, .failed (90/ 30)
    
### 4. Работа с MainViewController (660/775):
  * 4.1 Создание UITableView, установка констрейнтов, подпись на делегаты и прочие настройки (30/15)
  *  4.2 Создание UITableViewCell. Создание UI Элементов, подобрать шрифты стаки, констрейнты, выровнять, причесать (60/55):
       По дефолту лейбл даты рождения должен быть скрыт.
  *  4.3 Постараться найти Скелетон для UITableViewCell, установить его и поставить в состояние по дефолту (40/ 110) - Были проблемы с настройкой скелетона
  *  4.4 Разобрать с шапкой таблицы, узнать в сообществе (20/ 20)
  *  4.5 Создать кастомный SearchField (60/ 60)
  *  4.6 Создать SegmentedControll ?? Или CollectionView в хедере, но сперва разобраться (120 / 240):
       У элементов в этом контроллере должен быть индекс, по клику на который будет перегружаться таблица, а DataSource будет произодвить фильтрацию по департаменту и отоброжать это в ячейки. - Долго возился с настройкой всех зависимостей и анимаций.
  *  4.7 Настроить методы для поиска через SearchBar(60/ 55): Искать должно по массиву [Employees], по Имени/Фамилии/Почте
  *  4.8 Настроить пагинацию, добавить активити индикатор(120/ 45)
  *  4.9 Создать Header : ReusableView для таблицы, для отображения годов рождения после фильтрации через SearchBar (30/ 60+) - не добавлено
  *  4.10 Создание ячейки/вью "Ничего не нашли", если при поиске ничего не сошлось (60/ 30)
  *  4.10 Непредвиденные задачи(120/ 85): написать архитектуру, пару доп словарей. Прописать заглушки для картинок. Координатор
### 5. Создание экрана ErrorViewController (60/ 21):
   * 5. Накидать UI лейблы, имаджВью, создать кнопку, по которой произойдет открытие MainViewController (60/21)
        
### 6. Работа с DetailsViewController (190/190):
  *  6.1 Собсна настроить didSelectItem в MainViewController. При клике на ячейку передаем всю информацию модели в DetailsViewController. Повозиться с вьюМоделями. (40/30)
  *  6.2 Накидать UI. Состоять из 2 блоков будет - вернего и нижнего. Верхний блок - лейблы имаджи кнопка и стаки, на имедж добавить тень для объема. Цвет более темный. Нижний блок - Лейблы в стаках. Нижний лейбл кликабельный. (90/90)
  *  6.3 При нажатии на нижний лейбл работать UITapGestureRecognizer. Работаем с встроенным функционалом, нарыть как делать вызов системно таким образом actionSheet. Когда звонок начинается, то actionSheet закрывается. Как нароем, добавить туда блюр на бекграунд и затемнить. Ну или хотя бы просто блюр. НУ или затемнить, накинув поверх всего темный Вью и прозрачностью. (60/60) + работа с форматтером дат и маской телефона
    
### 7. Задачи под звездочкой (300/ 175):
  *  7.1.1 Создать view, с опциональным текстом. Текст может быть 2 видов (40/ 25):
   *   - "Не могу обновить данные. Проверь соединение с интернетом." Это если Отсутствует интернет соединение.
   *   - "Не могу обновить данные. Что-то пошло не так". Это если Ошибка API
  *  7.1.2 Если при загрузке списка людей произошла ошибка, необходимо показать этот View с текстом ошибки. Уведомление закрывает собой Status bar. Оно должно скрываться спустя 3 секунды, также его можно убрать тапом. *Это надо работать через Animate, там транзиштен чотатам. Посмотреть в видео у Ильдара.* (80/100) - Проблемы возникли на этапе добавления вью поверх НавБара, решилось сменой z на -1 у навбара
   
*   7.2 Создать анимированный индикатор pull-to-refresh (180/ 50):
   *    7.2.1 найти годную информацию с кодом какак это работает и изучить (60/30)
   *    7.2.2 Внедрить то же самое себе в код (120/20) - думал придется самому писать, но нашел готовые решения

    Итого: 
     - Запланировано 1640 минут
     - Выполнено за 1417.
     Некотоыре вещи шли сильно быстрее задуманного, а над некоторыми пришлось повозиться + непредвиденные методы и запары. 



   
   
   
   
   
