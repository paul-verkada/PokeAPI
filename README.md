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

do {
  let pokemons = try await PokeAPI.listPokemon()
  print(pokemons)
} catch {
  print(error)
}
```

ImageDownloader example
```swift
import PokeAPI

do {
  let image = try await ImageDownloader.getImage(withURL: url)
  let imageView = UIImageView(image: image)
} catch {
  print(error)
}
```
