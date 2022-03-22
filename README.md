# PokeAPI
API wrapper for the [PokeAPI](https://pokeapi.co/) written in Swift.

List Pokemon API example
````
PokeAPI.listPokemon() { [weak self] result in
  guard let self = self else { return }
  switch result {
  case .success(let pokemon):
    print(pokemon)
  case .failure(let error):
    print(error)
  }
}
````

ImageDownloader example
````
ImageDownloader.getImage(withURL: url) { result in
  switch result {
  case .success(let image):
    let imageView = UIImageView(image: image)
  case .failure(let error):
    print(error)
  }
}
````
