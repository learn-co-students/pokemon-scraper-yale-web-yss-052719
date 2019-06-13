class Pokemon

  attr_accessor :name, :id, :type, :db, :hp

  def initialize(id = nil, name = "Pikachu", type = "electric", db)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(num, db)
   pokemon = db.execute("SELECT * FROM pokemon WHERE id=?", [num]).flatten
   new_pokemon = self.new(pokemon)
   new_pokemon.id = pokemon[0]
   new_pokemon.name = pokemon[1]
   new_pokemon.type = pokemon[2]
   new_pokemon
 end

end
