class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(name:, type:, db:, id:nil)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    # def self.create(name:, type:)
    #     pokemon = Pokemon.new(name, type, db)
    #     pokemon.save
    #     pokemon
    # end

    # def self.new_from_db(array)
    #     pokemon = Pokemon.new("", "")
    #     pokemon.id = array[0]
    #     pokemon.name = array[1]
    #     pokemon.type = array[2]
    #     pokemon
    #   end

    def self.save(name, type, db)
            sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
            SQL

            db.execute(sql, name, type)
            @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT *
        FROM pokemon
        WHERE id = ?
        LIMIT 1
        SQL

        row = db.execute(sql, id)[0]
        Pokemon.new(name: row[1], type: row[2], db: db, id: row[0])
    end

    def self.create_table
        sql = <<-SQL
        CREATE TABLE IF EXISTS pokemon (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            type TEXT
        )
        SQL

        db.execute(sql)
    end



end
