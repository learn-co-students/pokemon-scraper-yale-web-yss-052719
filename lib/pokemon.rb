

class Pokemon
    attr_accessor :id, :name, :type, :db
    
    def initialize(attributes)
        attributes.each do |attribute, value|
            #binding.pry
            if self.respond_to?("#{attribute}=")
                self.send("#{attribute}=", value)
            end

        end
        
    end

    def self.save(name, type, db)
        sql =<<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        SQL
        attributeHash = { name: name, type: type, db: db}
        pokemon = Pokemon.new(attributeHash)
        #binding.pry
        pokemon.db.execute(sql, pokemon.name, pokemon.type)
        sql2 =<<-SQL
        SELECT * FROM pokemon
        SQL

        #binding.pry
    end

    def self.find(id, db)
        sql =<<-SQL
        SELECT * FROM pokemon WHERE id = ?
        SQL
        attributeHash = {id: id, db: db}
        pokemon = Pokemon.new(attributeHash)
        row = pokemon.db.execute(sql, pokemon.id)[0]
        attributeHash2 =  {id: row[0], name: row[1], type: row[2]}
        pokemon2 = Pokemon.new(attributeHash2)
        pokemon2
        #binding.pry
    end



end
