class Pokemon
	attr_accessor :name, :type 
	attr_reader :id, :db

	def initialize(id:, name:, type:, db:)
		@id = id
		@name = name
		@type = type
		@db = db
	end

	def self.save(name, type, db)
		poke = Pokemon.new(id: 1, name: name, type: type, db: db)
		db = poke.db
		db.execute( "INSERT INTO pokemon ( name, type) VALUES ( ?, ? )", [name, type])
	end

	def self.find(num, db)
		found = db.execute("SELECT * FROM pokemon WHERE id = ?", [num])[0]
		Pokemon.new(id: num, name: found[1], type: found[2], db: db)
	end

end
