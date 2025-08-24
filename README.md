# تطبيق القرآن الكريم

تطبيق Flutter للقرآن الكريم مع إمكانية عرض السور والراديو.

## المميزات

- 📖 عرض جميع سور القرآن الكريم
- 🎵 راديو القرآن الكريم
- 🎨 واجهة مستخدم جميلة وسهلة الاستخدام
- 📱 متوافق مع جميع الأجهزة
- 🔄 إدارة حالة التطبيق باستخدام BLoC
- 🌐 جلب البيانات من API خارجي

## التقنيات المستخدمة

- **Flutter**: إطار العمل الرئيسي
- **Dart**: لغة البرمجة
- **BLoC Pattern**: لإدارة حالة التطبيق
- **Dio**: لطلبات HTTP
- **flutter_svg**: لعرض الصور SVG

## هيكل المشروع

```
lib/
├── core/
│   ├── utils/
│   │   ├── app_assets.dart
│   │   └── app_colors.dart
│   └── widgets/
│       ├── custom_category_button.dart
│       ├── custom_suwar.dart
│       └── logo_name.dart
├── features/
│   ├── home/
│   │   ├── data/
│   │   │   ├── cubit/
│   │   │   │   ├── home_cubit/
│   │   │   │   │   ├── home_cubit.dart
│   │   │   │   │   └── home_state.dart
│   │   │   │   └── suwar_cubit/
│   │   │   │       ├── suwar_cubit.dart
│   │   │   │       └── suwar_state.dart
│   │   │   └── models/
│   │   │       ├── radio_model.dart
│   │   │       ├── surah_model.dart
│   │   │       └── suwar_page_model.dart
│   │   └── presentation/
│   │       └── views/
│   │           ├── home_view.dart
│   │           └── suwar_view.dart
│   └── splash/
│       └── splash_view.dart
└── main.dart
```

## التثبيت والتشغيل

1. تأكد من تثبيت Flutter على جهازك
2. استنسخ المشروع:
   ```bash
   git clone <repository-url>
   cd quran_app
   ```

3. قم بتثبيت التبعيات:
   ```bash
   flutter pub get
   ```

4. شغل التطبيق:
   ```bash
   flutter run
   ```

## API المستخدم

يستخدم التطبيق API من [mp3quran.net](https://mp3quran.net/api/v3/) لجلب:
- قائمة السور
- قائمة الراديو
- صفحات السور

## إدارة الأخطاء

التطبيق يتضمن إدارة شاملة للأخطاء:
- فحص الاتصال بالإنترنت
- رسائل خطأ واضحة باللغة العربية
- إمكانية إعادة المحاولة
- معالجة الأخطاء في parsing البيانات

## المساهمة

نرحب بمساهماتكم! يرجى:
1. Fork المشروع
2. إنشاء branch جديد للميزة
3. Commit التغييرات
4. Push إلى Branch
5. إنشاء Pull Request

## الترخيص

هذا المشروع مرخص تحت رخصة MIT.

## الدعم

إذا واجهت أي مشاكل، يرجى إنشاء issue في GitHub.
