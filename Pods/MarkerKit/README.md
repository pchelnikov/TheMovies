![MarkerKit](https://github.com/pchelnikov/MarkerKit/blob/master/Assets/marker-kit.jpg)

# MarkerKit
Lightweight and easy to use wrapper for Auto Layout Constraints (iOS 8+ support), inspired by [https://github.com/ustwo/autolayout-helper-swift](https://github.com/ustwo/autolayout-helper-swift)

[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/pchelnikov/MarkerKit/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/MarkerKit.svg?style=flat)](https://github.com/pchelnikov/MarkerKit)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/MarkerKit.svg)](https://cocoapods.org/pods/MarkerKit)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Requirements

- iOS 8.0+
- Xcode 9.0+
- Swift 4.0+

## Installation

### CocoaPods

You can use [CocoaPods](http://cocoapods.org/?q=MarkerKit).

```bash
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
  pod 'MarkerKit'
end
```

#### Carthage 
You can use [Carthage](https://github.com/Carthage/Carthage). 
Specify in Cartfile:

```bash
github "pchelnikov/MarkerKit"
```

Run `carthage` to build the framework and drag the built MarkerKit.framework into your Xcode project. Follow [build instructions](https://github.com/Carthage/Carthage#getting-started).

### Manually

- Add the `MarkerKit.swift` file to your Xcode project.

## Usage

### Quick Start

```swift
import MarkerKit

class MyViewController: UIViewController {

    lazy var myView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(myView)
        
        myView.mrk.height(50)
        myView.mrk.width(50)
        myView.mrk.center(to: view)
    }
}
```

### More examples:

**Edges placing**

```swift
// Create view
    
let myView = UIView()
myView.backgroundColor = UIColor.red
view.addSubview(myView)
    
// Add constraints
    
myView.mrk.top(to: view, attribute: .top, relation: .equal, constant: 10.0)
myView.mrk.leading(to: view, attribute: .leading, relation: .equal, constant: 10.0)
myView.mrk.trailing(to: view, attribute: .trailing, relation: .equal, constant: -10.0)
myView.mrk.bottom(to: view, attribute: .bottom, relation: .equal, constant: -10.0)
```

or shorter you can omit the attributes:

```swift
myView.mrk.top(to: view, constant: 10.0)
myView.mrk.leading(to: view, constant: 10.0)
myView.mrk.trailing(to: view, constant: -10.0)
myView.mrk.bottom(to: view, constant: -10.0)
```

or even shorter using `fillSuperview`:

```swift
let edgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
myView.mrk.fillSuperview(edgeInsets)
```

**Centering**

```swift
myView.mrk.centerX(to: view)
myView.mrk.centerY(to: view)
```

or equivalent:

```swift
myView.mrk.center(to: view)
```

**Measurements**

Constraints for width and height:

```swift
myView.mrk.width(100)
myView.mrk.height(100)
```

**Modify constraints**

```swift
// Create a reference to the `NSLayoutConstraint` e.g. for height

let heightConstraint = myView.mrk.height(100)
```

...

```swift

// Update the height constant

heightConstraint.constant = 30.0

// Animate changes

UIView.animate(withDuration: 0.3) {
    self.view.layoutIfNeeded()
}
```

## What to do next

* Writing tests

## License

MarkerKit is available under the MIT license. See the LICENSE file for more info.
