class PokemonsController < ApplicationController
  def index
    response = RestClient.get("https://pokeapi.co/api/v2/pokemon?offset=0&limit=10")
    result = JSON.parse response
    api_pokemons = result["results"]
    pokemons = api_pokemons.reduce([]) do |poke_list, api_pokemon|
      poke_response = RestClient.get api_pokemon["url"]
      poke_result = JSON.parse poke_response
      poke_list << poke_result
      poke_list
    end
    render json: pokemons
  end
end
