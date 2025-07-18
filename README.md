Bu dosya yapısı, birden fazla iOS uygulamasını ve paylaşılan kod modüllerini tek bir merkezi depoda (monorepo) barındırmak için tasarlanmıştır. Bu yaklaşım, **kodun yeniden kullanımını**, **modülerliği** ve **uygulamalar arası tutarlılığı** artırırken, geliştirme sürecini de kolaylaştırmayı hedefler.

-----

### Dosya Yapısı

```
ios-mono-repo/
├── ios-mono-repo.xcworkspace/
│   ├── contents.xcworkspacedata
│   └── xcshareddata/
│       └── WorkspaceSettings.xcsettings
│
├── Apps/
│   ├── App1/
│   │   ├── App1.xcodeproj/
│   │   │   ├── project.pbxproj
│   │   │   └── xcshareddata/
│   │   │       └── xcschemes/
│   │   │           └── App1.xcscheme
│   │   ├── App1/
│   │   │   ├── Info.plist
│   │   │   ├── AppDelegate.swift
│   │   │   └── ViewController.swift
│   │   └── SupportingFiles/
│   │       ├── Assets.xcassets
│   │       └── LaunchScreen.storyboard
│   └── App2/
│       ├── App2.xcodeproj/
│       │   ├── project.pbxproj
│       │   └── xcshareddata/
│       │       └── xcschemes/
│       │           └── App2.xcscheme
│       ├── App2/
│       │   ├── Info.plist
│       │   ├── AppDelegate.swift
│       │   └── ViewController.swift
│       └── SupportingFiles/
│           ├── Assets.xcassets
│           └── LaunchScreen.storyboard
│
├── Packages/
│   ├── Core/
│   │   ├── Package.swift
│   │   └── Sources/
│   │       ├── Core/
│   │       │   ├── Core.swift
│   │       │   └── ...
│   ├── DesignSystem/
│   │   ├── Package.swift
│   │   └── Sources/
│   │       └── DesignSystem/
│   │           ├── Button.swift
│   │           └── Theme.swift
│   └── Features/
│       ├── FeatureA/
│       │   ├── Package.swift
│       │   └── Sources/
│       │       └── FeatureA/
│       │           ├── FeatureAView.swift
│       │           └── ...
│       └── FeatureB/
│           ├── Package.swift
│           └── Sources/
│               └── FeatureB/
│                   ├── FeatureBView.swift
│                   └── ...
│
└── README.md
```

-----

### Yapının Temel Bileşenleri

  * **`ios-mono-repo.xcworkspace/`**: Bu Xcode çalışma alanı dosyası, monoreponun kalbidir. Tüm uygulamaları (`Apps/` altındaki `.xcodeproj` dosyaları) ve paylaşılan Swift paketlerini (`Packages/` altındaki paketleri) bir araya getirir. Geliştiriciler bu çalışma alanını açarak tüm projelere tek bir yerden erişebilir.

  * **`Apps/`**: Bu dizin, monorepo içindeki bağımsız iOS uygulamalarını içerir. Her uygulama (örneğin `App1`, `App2`) kendi Xcode projesine (`.xcodeproj`), uygulama kaynak kodlarına (`Info.plist`, `AppDelegate.swift`, `ViewController.swift`) ve destekleyici dosyalara (`Assets.xcassets`, `LaunchScreen.storyboard`) sahiptir.

  * **`Packages/`**: Monoreponun en önemli avantajlarından birini sunan bu dizin, birden fazla uygulama tarafından kullanılacak ortak kod modüllerini barındırır. Bu modüller **Swift Paketleri** olarak tanımlanmıştır:

      * **`Core/`**: Temel yardımcı fonksiyonlar, genel servisler veya uygulamalar arası ortak mantık gibi çekirdek işlevleri içerir.
      * **`DesignSystem/`**: Uygulamaların kullanıcı arayüzü bileşenlerini (örneğin `Button.swift`) ve tema tanımlarını (`Theme.swift`) merkezileştirir. Bu, tüm uygulamalarda görsel tutarlılık sağlar.
      * **`Features/`**: Uygulamaların belirli özelliklerini (örneğin `FeatureA`, `FeatureB`) bağımsız modüller halinde gruplar. Her özellik, kendi görünüm denetleyicileri veya iş mantığı gibi bileşenleri içerebilir.

-----

### Neden Bu Yapı?

Bu monorepo yapısı, özellikle çok sayıda uygulamanın birbirine benzer veya ortak bileşenler paylaştığı durumlarda tercih edilir. Geliştiricilerin tek bir depoda çalışmasına olanak tanıyarak **bağlam değiştirme maliyetini azaltır**, **kod tekrarını önler** ve yeni uygulamaların veya özelliklerin geliştirilmesini hızlandırır. Swift Paketlerinin kullanımıyla bağımlılık yönetimi de Xcode'un yerel araçlarıyla entegre bir şekilde sağlanır.
