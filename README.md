# 📚 Library User

**Library User**, Flutter ve Firebase teknolojileri kullanılarak geliştirilen bir **kütüphane uygulamasının kullanıcı tarafıdır**. Kullanıcılar kitapları görüntüleyebilir, detaylarını inceleyebilir, çantalarına ekleyebilir ve modern bir arayüzle etkileşime geçebilirler. Uygulama; Android, iOS, Web ve masaüstü platformlarında çalışacak şekilde çoklu platform desteğiyle yapılandırılmıştır.

---

## ✨ Özellikler

- 🔐 Google hesabı ile giriş (Firebase Authentication)
- 📚 Kitapları listeleme, detaylarını görme ve kullanıcı çantası
- 🎯 Kategoriye göre filtreleme ve arama
- 🖼️ Firebase Storage ile kitap kapaklarını görüntüleme
- 🔥 Firestore ile gerçek zamanlı veri senkronizasyonu
- 🎨 Lottie animasyonları, shimmer efektleri ve dinamik UI
- 🧱 Responsive tasarım – mobil, web, masaüstü uyumlu

---

## 🛠️ Kullanılan Teknolojiler ve Paketler

- **Flutter** – UI geliştirme çatısı
- **Firebase Core / Auth / Firestore / Storage** – kullanıcı, veri ve medya yönetimi
- **Provider** – state management
- **Shared Preferences** – kullanıcı ayarlarının saklanması
- **Lottie**, **Shimmer** – animasyonlar ve efektler
- **Card Swiper**, **Fancy Shimmer Image** – görsel geçiş ve kart yapıları
- **Image Picker**, **UUID**, **Toast**, **HTTP** – yardımcı fonksiyonlar

---

## 🚀 Kurulum

```bash
# 1. Projeyi klonla
git clone https://github.com/AlbayEmre/Library_User.git
cd Library_User

# 2. Gerekli paketleri yükle
flutter pub get

# 3. Uygulamayı başlat (cihaza göre değiştir)
flutter run -d chrome
# veya: flutter run -d android / ios / windows
