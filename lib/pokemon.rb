require "pry"
class Pokemon

    attr_accessor :id, :name, :type, :db, :hp

    def initialize(id:, name:, type:, db:, hp:60)
        @id = id
        @name = name
        @type = type
        @hp = hp
        @db = db
    end

    def self.save(name, type, db)
        sql = "INSERT INTO pokemon (name, type) VALUES (?, ?)"
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid () FROM pokemon")[0]
    end
    
    def self.find(id, db)
        sql = "SELECT * FROM pokemon WHERE id = ?"
        result = db.execute(sql, id)[0]
        Pokemon.new(id: result[0], name: result[1], type: result[2], db:db)
    end

    def alter_hp(num, db)
        sql = "UPDATE pokemon SET hp = ? WHERE id = @id"
        pokemon.execute(sql, num)
    end
end
