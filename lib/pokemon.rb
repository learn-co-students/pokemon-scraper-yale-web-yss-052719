class Pokemon
    attr_accessor :name, :type, :id, :db

    def initialize(name:, type:, id:, db:)
        @name = name
        @type = type
        @db = db
        @id = id
    end



    def self.save(name, type, db)
        db.execute("INSERT INTO pokemon (name, type)
        VALUES (?, ?)", name, type)
    end
    

    def self.find(id, db)
        temp = db.execute("SELECT * 
            FROM pokemon 
            WHERE id = (?);", id).flatten
        poke = Pokemon.new(:name => temp[1], :type => temp [2], :id => id, :db => db)
        poke
    end

end
