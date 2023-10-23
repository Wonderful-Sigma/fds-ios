# Flick 디자인 시스템

![Swift](https://img.shields.io/badge/Swift-5.5_5.6_5.7_5.8-Orange?style=flat-square)
![Platforms](https://img.shields.io/badge/Platforms-macOS_iOS-yellowgreen?style=flat-square)
![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)

SwiftUI를 위한 Flick의 디자인 시스템.

## 요구사항
| 플랫폼 | 최소 Swift 버전 | 설치 방법 |
| --- | --- | --- |
| iOS 15.0+ / macOS 10.12+ | 5.5 | [Swift Package Manager](#swift-package-manager) |

## 설치 방법
### Swift Package Manager
- `File` -> `Add Packages...` 에서 Repository의 URL을 붙여넣으세요.
- 아니면 `Package.swift`의 `dependencies` 값에 밑의 코드를 붙여넣으세요.
```swift
dependencies: [
    .package(url: "https://github.com/Wonderful-Sigma/fds-ios.git", .branch("main"))
]
```

## 컴포넌트
- [LargeButton](#largebutton)
- [SmallButton](#smallbutton)
- [CoinCell](#coincell)
- [Modal](#modal)
- [QRCodeView](#qrcodeview)

## 예제
```swift
import OpenTDS
```

### LargeButton
> 홈 화면의 큰 버튼

### SmallButton
> 홈 화면의 작은 버튼

### CoinCell
> 코인과 타이틀을 표시하는 Cell

### Modal
> 커스텀 Modal View

### QRCodeView
> QR코드 생성을 위한 View
