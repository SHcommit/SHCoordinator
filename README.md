# Welcome : ]

## Introduce

The Coordinator pattern is a design pattern used in iOS application architecture. Use individual coordinator objects that are responsible for the app's navigation, screen-to-screen transitions, and flow.

Coordinators are responsible for managing specific screens or features. Each coordinator can handle the status and operation of the corresponding screen or function, and can control screen transitions to other coordinators.

Separating your app's structure makes it easier to maintain and test, and you can clearly manage and track your app's navigation flow.

In fact, every time I introduce a coordinator pattern to a project, I accidentally found out about the concept of modularization while copying and pasting, and it was developed as an open source through the swift package and cocoapods.


## Installation
SHCoordinator supports [Swift Package Manager](https://www.swift.org/package-manager/) If that doesn't work for you, you can check and use binary frameworks attached to the [releases](https://github.com/SHcommit/SHCoordinator/releases/)

#### QnA) So,,, how to generate SHCoordinator library?
___

### [SPM]
 Add package dependency using xcode swiftPM
1. Xcode upper menu. 'File'
2. Find "Add Packages..." and click.
3. Search My Package repository with dependency rule(Up to Next Major Version)
> https://github.com/SHcommit/SHCoordinator.git
4. Add Package

Finally, add `Import SHCoordinator` to your source code.

___
### [Cocoapods]
1. Please execute the  `pod init` command in the terminal from the root directory where the xcodeproj project file is located.
2. Then, open the Podfile using `vim Podfile` commend.
3. Add `'SHCoordinator', '3.0.1' ` dependency inside target 'MyProejct' do ... end block. then save the Podfile using `:wq` commend.
4. Enter the commend `pod install` 

Finally, open the proejct.xcodeproj, closed it, and then open proejct.xcworkspace file.
After that, add `Import SHCoordinator` to your source code.

## Minimum Requirements
| SHCoordinator       | Date         | Swift        | Platforms                           |
|------------|--------------|-------------|-----------------------------------------------|
| SHCoordinator 1.0.2  | June 29, 2023  | Swift 5.0   | iOS 13.0 |
| SHCoordinator 2.0.0  | September 18, 2023  | Swift 5.0   | iOS 13.0 |
| SHCoordinator 3.0.1  | October 28, 2023  | Swift 5.0   | iOS 13.0 |

## License

SHCoordinator is available under the MIT license. See the LICENSE file for more info.
