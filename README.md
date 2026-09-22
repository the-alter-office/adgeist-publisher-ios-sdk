[![Swift Package](https://img.shields.io/github/v/release/the-alter-office/adgeist-publisher-ios-sdk?label=Swift%20Package)](https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases)

---

# Adgeist Mobile Ads SDK for iOS

This guide is for publishers who want to monetize an iOS app with Adgeist.

## Prerequisites

- Xcode 16.0 or higher
- Deployment target of iOS 15.6 or higher
- An Adgeist publisher account with your bundle ID whitelisted

## Configure your app

### STEP 1: Add the dependency

AdgeistKit is distributed as a binary Swift package. It has no dependencies of its own.

#### Method 1: Xcode

1. File → Add Package Dependencies.
2. Enter the package URL:

```
https://github.com/the-alter-office/adgeist-publisher-ios-sdk
```

3. Choose **Up to Next Major Version** from the latest release.
4. Add the `AdgeistKit` library to your app target.

#### Method 2: Package.swift

1. Add the package to your `dependencies`:

```swift
.package(
    url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk.git",
    from: "1.0.18"
)
```

2. Add the product to the target that uses it:

```swift
.product(name: "AdgeistKit", package: "adgeist-publisher-ios-sdk")
```

### STEP 2: Configure Info.plist

Add your Adgeist publisher ID (as identified in the Adgeist web interface) to your app's `Info.plist` under the key `ADGEIST_APP_ID`:

```xml
<!-- Sample Adgeist app ID: 69326f9fbb280f9241cabc94 -->
<key>ADGEIST_APP_ID</key>
<string>YOUR_ADGEIST_ID</string>
```

Every ad request is attributed to this ID, and the request `Origin` is your app's bundle identifier — both must match what is registered in the Adgeist dashboard.

`NSUserTrackingUsageDescription` is required when the app requests tracking authorisation, whether through STEP 4 or through `ATTrackingManager` directly. The system terminates apps that use the AppTrackingTransparency framework without it.

```xml
<key>NSUserTrackingUsageDescription</key>
<string>YOUR_REASON</string>
```

### STEP 3: Initialize the Adgeist Mobile Ads SDK

Call `AdgeistCore.shared.initialize()` as early as possible in your app's lifecycle. It warms the web view, the network connection, and the render assets so the first ad paints faster.

```swift
import SwiftUI
import AdgeistKit

@main
struct MyApp: App {

    init() {
        AdgeistCore.shared.initialize()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
```

From `UIApplicationDelegate`:

```swift
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    AdgeistCore.shared.initialize()
    return true
}
```

Initialization is a warm-up only. Ads load without it, just more slowly on first paint.

### STEP 4: Request tracking authorisation (optional)

Authorised tracking improves targeting. Ads serve without it.

```swift
let authorised = await AdgeistCore.shared.requestAdTrackingAutorisation()
```

Returns `true` when tracking is authorised. The system prompt is presented only while the app is active and authorisation is undetermined.

Apps that call `ATTrackingManager.requestTrackingAuthorization` directly must not call this method. The SDK uses the authorisation status already established by the app.

Authorisation is resolved once per launch, so call this before the first ad loads.

## Display an ad

An ad space is identified by the ad space ID you created in the Adgeist dashboard. The format — banner, display, or companion — is configured server side and resolved at request time; you do not declare it in the app.

### SwiftUI

Place an `AdBanner` in your hierarchy. It loads itself when it appears.

```swift
import SwiftUI
import AdgeistKit

struct FeedView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Sponsored")

                AdBanner(adId: "YOUR_AD_SPACE_ID")

                // your content
            }
            .padding()
        }
    }
}
```

To hold layout space while the ad is in flight, pass a size and `reserveSpace: true`:

```swift
AdBanner(
    adId: "YOUR_AD_SPACE_ID",
    width: 320,
    height: 300,
    reserveSpace: true
)
```

### UIKit

Create an `AdView`, add it to your hierarchy, then call `load()`.

```swift
import UIKit
import AdgeistKit

final class FeedViewController: UIViewController {

    private let adView = AdView(adUnitId: "YOUR_AD_SPACE_ID")

    override func viewDidLoad() {
        super.viewDidLoad()

        adView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(adView)

        NSLayoutConstraint.activate([
            adView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            adView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])

        adView.load()
    }
}
```

`AdView` supplies its own intrinsic content size, so do not pin its width or height — constrain position only and let the ad size itself.

`AdView` is `@MainActor`; create it and call `load()` from the main thread. It has no `init(coder:)`, so it cannot be placed in a storyboard or xib — construct it in code.

## Sizing

| Parameter      | Purpose                                                        |
| -------------- | -------------------------------------------------------------- |
| `width`        | Fallback width, used only if the server returns no dimensions  |
| `height`       | Fallback height, used only if the server returns no dimensions |
| `reserveSpace` | Occupies `width` × `height` until the ad resolves              |

Dimensions returned by the server always win. The `width` and `height` you pass are a fallback for the case where the response carries none.

With `reserveSpace: false` (the default) the view has zero size until the ad resolves, then grows to fit — surrounding content shifts. With `reserveSpace: true` the view claims `width` × `height` immediately, so the layout is stable from first render. `reserveSpace` requires both `width` and `height`.

If the server returns no dimensions and you passed no `width`/`height`, the ad has no size and will not be visible.

---

## Support

If you run into any difficulties while integrating or using the Adgeist Mobile Ads SDK, reach out to beast@thealteroffice.com and we'll help you get it sorted out.
