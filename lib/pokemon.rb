require "pry"
class Pokemon
    attr_reader :id
    attr_accessor :name, :type, :db, :hp

    def initialize(name:, type:, db:, hp:nil, id:nil)
        @name = name
        @type = type
        @db = db
        @hp = hp
        @id = id
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) VALUES (?,?)
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon
            WHERE id = ?
        SQL

        row_array = db.execute(sql, id)
        row = row_array[0]

        Pokemon.new(name: row[1], type: row[2], db: db, id: row[0], hp: row[3])
    end

    def alter_hp(number, db)
        sql = <<-SQL
            UPDATE pokemon
            SET hp = ?
            WHERE id = ?
        SQL

        db.execute(sql, number, self.id)
    end
end
