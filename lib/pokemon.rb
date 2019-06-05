require_relative("../bin/environment.rb")
class Pokemon
    attr_accessor :id, :name, :type, :hp, :db

    def initialize(id = nil, name = nil, type = nil, hp = nil, db)
        @id = id
        @name = name
        @type = type
        @hp = hp
        @db = db
    end

    def self.save(name, type, db)
        sql = "INSERT INTO pokemon (name, type) VALUES (?, ?);"
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.new_from_db(row, db)
        pokemon = Pokemon.new(db)
        pokemon.id = row[0]
        pokemon.name = row[1]
        pokemon.type = row[2]
        pokemon.hp = row[3]
        pokemon
    end

    def self.find(id, db)
        sql = "SELECT * FROM pokemon WHERE id = ?;"
        db.execute(sql, id).map do |row|
            self.new_from_db(row, db)
        end.first
    end

    def alter_hp(hp, db)
        sql = "UPDATE pokemon SET hp = ? WHERE id = ?;"
        db.execute(sql, hp, self.id)
    end
    
end
