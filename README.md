# 📒 CitiesSearch
A Sample of how you can search offline in large files

<!--[![CI Status](https://img.shields.io/travis/AhmedAskar/CitiesSearch.svg?style=flat)](https://travis-ci.org/AhmedAskar/CitiesSearch)-->

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)
[![Platform](https://img.shields.io/cocoapods/p/AlamofireLogbook.svg?style=flat)](https://developer.apple.com/resources/)
[![Swift Version](https://img.shields.io/badge/swift-4.1-orange.svg?style=flat)](https://swift.org/blog/swift-4-1-released/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat)](http://makeapullrequest.com)

## Implementation
The solution based on seperating large cities.json into prefixCharchter.json files to produce high performance while loading and reading from this file.

Search algorithm based on insert cities into Tries so, what is Trie ?

Tries are n-ary trees in which characters are stored at each node and also a key data structure that facilitates efficient prefix matching.

## Usage
We have two main classes CityNode and CitiesTrie, each CityNode will represent a character of a word and the CitiesTrie class will manage the insertion logic and keep a reference to the nodes.

You can read more about Trie algorithm and how to implement it to fit your case.

The main logic to make the search very fast is that you map the character prefix and load it is cities tree and after that hasing them (key, value) > key represents the charachter and the value represents the citiesTree

```swift
for city in cities {
citiesTrie.insert(city: city)
}
dicOfTries[fileCharPrefix] = citiesTrie
// Your code
}
```

So once you already have loaded the citiesTree so you don't have to load the cities again.

```swift
// Case filePrefix is already loaded and dict contains Trie data of cities
if let trie = dicOfTries[fileCharPrefix] {
let searchCities = trie.find(prefix: prefix)
}
}
```

## Requirements

- iOS 9.0+
- Xcode 9+
- Swift 3.2+

## Contributions

If you have some ideas on how to improve the network layer, Fork it, implement your changes and create that pull request already 😉.

All contributions are welcome 🤗.

## Author

Built with 💙 by [AhmedAskar](https://github.com/AhmedAskar)

## License

CitiesSearch is available under the MIT license. See the LICENSE file for more info.
