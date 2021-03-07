# Movies
Used MVVM architecture. As possible as tried to use Protocol oriented programming. 
## Dependencies 
Used Swift package manager (https://swift.org/package-manager/) to integrate third party frameworks 
* Swinject - Dependency injection framework [GitHub] (https://github.com/Swinject/Swinject)
* Kingfisher - Image downloader [GitHub] (https://github.com/onevcat/Kingfisher)
* Alamofire - HTTP networking guide  [GitHub] (https://github.com/Alamofire/Alamofire)

## Techniques used:
* Diffable data sources (https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)
* Compositional layout (https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)
* Dependency injection 
* Use cases

## Unit testing:
Written unit tests for Search and Details modules, because of the time constraint covered importent classes. Since every section very lightly coupled there is room for writing as many tests as possible. Have not written any UI tests.

## Notes:

Focused more on functional stuff, there is the possibility to improve UI a lot due to time constraints stick with basic UI.
