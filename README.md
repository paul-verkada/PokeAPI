# PokeAPI
API wrapper for the [PokeAPI](https://pokeapi.co/) written in Swift.

## Installation
### Swift Package Manager

Search for this repository URL in Xcode:

File->Add Packages

```
https://github.com/paul-verkada/PokeAPI.git
```

## Examples
List Pokemon API example
```swift
import PokeAPI

PokeAPI.listPokemon() { result in
  switch result {
  case .success(let pokemons):
    print(pokemons)
  case .failure(let error):
    print(error)
  }
}
```

ImageDownloader example
```swift
import PokeAPI

ImageDownloader.getImage(withURL: url) { result in
  switch result {
  case .success(let image):
    let imageView = UIImageView(image: image)
  case .failure(let error):
    print(error)
  }
}
```
