[![Swift Package](https://img.shields.io/github/v/release/the-alter-office/adgeist-publisher-ios-sdk?label=Swift%20Package)](https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases)

---

# Adgeist Mobile Ads SDK for iOS

AdgeistKit is a binary Swift package with no dependencies of its own. It works with SwiftUI and UIKit, and needs Xcode 16 and iOS 15.6 or later.

Before ads will serve you need an Adgeist publisher account with your bundle ID whitelisted.

## Install

In Xcode, **File → Add Package Dependencies**, paste the URL, pick **Up to Next Major Version** from the latest release, and add **AdgeistKit** to your app target.

```
https://github.com/the-alter-office/adgeist-publisher-ios-sdk
```

Or in `Package.swift`:

```swift
.package(
    url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk.git",
    from: "1.0.25"
)
```

```swift
.product(name: "AdgeistKit", package: "adgeist-publisher-ios-sdk")
```

## Configure

Your publisher ID goes in `Info.plist` under `ADGEIST_APP_ID`. You'll find it in the Adgeist web interface.

```xml
<!-- Sample Adgeist app ID: 69326f9fbb280f9241cabc94 -->
<key>ADGEIST_APP_ID</key>
<string>YOUR_ADGEIST_ID</string>
```

Every ad request is attributed to that ID and carries your bundle identifier as its `Origin`. Both have to match what's registered in the dashboard. If either doesn't, the request is rejected and you get an `AW2` warning back.

No `ADGEIST_APP_ID` yet? You can still build against the SDK. [Preview](#preview) renders real ad layouts locally without an ID, an ad space or a network call, so the integration work doesn't have to wait on the dashboard.

## Initialize

Call `AdgeistCore.shared.initialize()` at launch, as early in the lifecycle as you can. It warms the web view, the network connection and the render assets so your first ad paints faster.

```swift
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

From an app delegate:

```swift
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    AdgeistCore.shared.initialize()
    return true
}
```

## Show an ad

In SwiftUI, `AdBanner` loads itself when it appears. Only `adId` is required:

```swift
import SwiftUI
import AdgeistKit

struct FeedView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Sponsored")

                AdBanner(
                    adId: "YOUR_AD_SPACE_ID",
                    width: 320,                      // CGFloat? = nil
                    height: 300,                     // CGFloat? = nil
                    reserveSpace: true,              // Bool = false
                    onEvent: { event in print(event.code) }
                )
            }
            .padding()
        }
    }
}
```

In UIKit, you set `onEvent` as a property and call `load()` yourself:

```swift
import UIKit
import AdgeistKit

final class FeedViewController: UIViewController {

    private let adView = AdView(
        adId: "YOUR_AD_SPACE_ID",
        width: 320,                                 // CGFloat? = nil
        height: 300,                                // CGFloat? = nil
        reserveSpace: true                          // Bool = false
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        adView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(adView)

        NSLayoutConstraint.activate([
            adView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            adView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])

        adView.onEvent = { event in print(event.code) }

        adView.load()
    }
}
```

`AdView` is `@MainActor` and has no `init(coder:)`, so build it in code and keep it off your storyboards.

That's the whole surface, apart from these:

```swift
AdgeistCore.shared.initialize()
await AdgeistCore.shared.requestAdTrackingAutorisation()    // -> Bool

struct AdgeistEvent {
    let code: String            // "AE1" and friends
    let type: AdgeistEventType  // .adLoaded | .adClicked | .adNoFill | .adNetworkError | .adWarning
    let message: String
    let data: [String: String]?
}
```

Everything except the ID has a default, so pass only what you need. Swift wants the arguments in the order above — you can skip any of them, but you can't reorder the ones you keep.

## Preview

Sometimes you want the layout settled before the ad space exists, or you want to check a format still renders after upgrading the SDK. `AdBannerPreview` and `AdViewPreview` render a sample creative through the same renderer the real ads use.

No ad request goes out, no ad space ID is involved, and `ADGEIST_APP_ID` doesn't need to be set. Nothing is reported either — no impressions, no clicks, no telemetry — so your live numbers stay clean.

```swift
AdBannerPreview(
    type: .display,        // .banner | .display | .companion
    media: .video,         // .image | .gif | .video
    isResponsive: true,    // true fills and crops, false letterboxes
    width: 300,
    height: 250
)
```

The UIKit version takes the same arguments and, like `AdView`, waits for `load()`. `onEvent` behaves as it does on the live components — an argument on `AdBannerPreview`, a property on `AdViewPreview`:

```swift
private let preview = AdViewPreview(
    type: .display,        // .banner | .display | .companion
    media: .video,         // .image | .gif | .video
    isResponsive: true,    // true fills and crops, false letterboxes
    width: 300,
    height: 250
)

override func viewDidLoad() {
    super.viewDidLoad()

    preview.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(preview)

    NSLayoutConstraint.activate([
        preview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        preview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
    ])

    preview.load()
}
```

Leave `creativeUrl` out and you get a bundled sample matched to your slot's aspect ratio. Point it at your own artwork when you have some:

```swift
AdBannerPreview(
    type: .companion,
    creativeUrl: "https://example.com/creative.mp4",   // 16:9 video for .companion
    companionUrl: "https://example.com/banner.png",    // 16:3 image, .companion only
    title: "Your headline",
    description: "Your body copy",
    ctaUrl: "https://example.com",
    width: 300,
    height: 250
)
```

Media type comes from the file extension, so an `.mp4` plays as video without you saying so. `ctaUrl` and `deepLinkUrl` behave exactly as they do on a live ad: the deep link is tried first and the CTA is the fallback. Empty `title` and `description` fall back to placeholder copy written at the real character limits, which is the quickest way to see where your own text will overflow — banners render neither, so don't expect them there. `reserveSpace` exists only so the argument lists match the live components; it does nothing here.

When the ad space is ready, delete the preview-only arguments, change the type and pass the ID. Everything about sizing and events stays put.

```swift
AdBannerPreview(type: .display, media: .video, width: 300, height: 250)
AdBanner(adId: "YOUR_AD_SPACE_ID",              width: 300, height: 250)
```

```swift
let preview = AdViewPreview(type: .display, media: .video, width: 300, height: 250)
let adView  = AdView(adId: "YOUR_AD_SPACE_ID",             width: 300, height: 250)
```

## Sizing

Pass the size of the slot you're filling. Leave an axis out and it fills its parent, so `height: 300` inside a `VStack` gives you a full-width ad 300 tall, and `width: 300` does the mirror image inside an `HStack`.

Server dimensions beat anything you pass. Treat `width` and `height` as a fallback for responses that don't carry their own, not as a demand.

By default the view has zero size until the ad resolves and then grows into place, which pushes whatever sits below it down the screen. When that matters, claim the space up front:

```swift
AdBanner(
    adId: "YOUR_AD_SPACE_ID",
    width: 320,
    height: 300,
    reserveSpace: true
)
```

If a non-responsive ad comes back with no dimensions and you passed none either, the ad fills its parent and you get an `AW1` warning. That's the SDK asking you for a size.

On the UIKit side, `AdView` reports its own intrinsic content size for fixed-size ads, so constrain where it sits rather than how big it is. For responsive ads, constrain the axes you didn't pass.

## Events

`onEvent` is optional and always called on the main thread.

```swift
AdBanner(adId: "YOUR_AD_SPACE_ID", onEvent: { event in
    switch event.type {
    case .adLoaded: break
    case .adClicked: break
    case .adNoFill: break
    case .adNetworkError: break
    case .adWarning: break
    }
})
```

In UIKit it's a property, and it needs to be set before `load()` runs:

```swift
adView.onEvent = { event in
    print(event.code, event.type.rawValue, event.message)
}

adView.load()
```

Each event carries a `code` (`AE1` and friends), a `type` (`AdgeistEventType`), a human-readable `message`, and sometimes `data`, which holds `reason` on load failures. Branch on `code` or `type`. The message text can be localized and isn't stable, so it's for your logs, not your logic.

## When ads don't show up

Attach `onEvent`, print the code, and check it against this list. It's almost always one of them.

**`AE1`** — no campaign is running for that ad space. Your integration is fine; hide the placement when you see it.

**`AW2`** — configuration. `ADGEIST_APP_ID` missing or wrong, bundle ID not whitelisted, or an ad space ID that doesn't exist.

**`AE2`** — the request didn't complete. Device offline, timed out, or a server error.

**`AW3`** — the creative didn't render. Send us the code and `data.reason`.

**`AL1`, but still a blank space** — the ad loaded into a slot with no height. See [Sizing](#sizing).

**No events at all** — `load()` never ran, or the view never made it into the window. UIKit needs the explicit call; SwiftUI handles it on appear.

When you can't tell whether it's your layout or the delivery, render the same placement with a [preview](#preview). If the preview looks right, the layout is sound and the problem is on the request side.

## Tracking authorisation

Optional. Tracking authorisation improves targeting, and ads serve without it.

```swift
let authorised = await AdgeistCore.shared.requestAdTrackingAutorisation()
```

You get `true` when tracking is authorised. The system prompt only shows while the app is active and authorisation is still undetermined, and the status is resolved once per launch — so call it before your first ad loads or it won't count until next time. If your app already calls `ATTrackingManager.requestTrackingAuthorization` itself, don't call this; the SDK picks up whatever status you've set.

Either way you need `NSUserTrackingUsageDescription` in `Info.plist`. iOS kills apps that touch AppTrackingTransparency without it.

```xml
<key>NSUserTrackingUsageDescription</key>
<string>YOUR_REASON</string>
```

## Event reference

Prefixes: `AL` lifecycle, `AI` interaction, `AE` error, `AW` warning.

| Code | type               | Meaning                | When it occurs                  | Possible cause                                                   | Recommended action                            |
| ---- | ------------------ | ---------------------- | ------------------------------- | ---------------------------------------------------------------- | --------------------------------------------- |
| AL1  | `AD_LOADED`        | Ad loaded successfully | Creative rendered               | —                                                                | —                                             |
| AI1  | `AD_CLICKED`       | Ad clicked             | User taps the ad                | —                                                                | —                                             |
| AE1  | `AD_NO_FILL`       | No ad available        | Server returns no ad            | No active campaign for the ad space                              | Hide the placement                            |
| AE2  | `AD_NETWORK_ERROR` | Ad request failed      | Ad request does not complete    | Device offline, timeout, or server error                         | Retry later                                   |
| AW1  | `AD_WARNING`       | Ad has no size         | After the ad response           | Server returned no dimensions and no `width`/`height` was passed | Pass `width` and `height`                     |
| AW2  | `AD_WARNING`       | Invalid configuration  | Before or during the ad request | Missing `ADGEIST_APP_ID`, or request rejected (HTTP 4xx)         | Check `Info.plist` and the ad space ID        |
| AW3  | `AD_WARNING`       | Ad failed to render    | While rendering the creative    | Invalid creative or web view error                               | Contact support with `code` and `data.reason` |

A load cancelled by a newer `load()` call emits nothing.

---

## Support

If you run into any difficulties while integrating or using the Adgeist Mobile Ads SDK, reach out to contact@thealteroffice.com and we'll help you get it sorted out.
