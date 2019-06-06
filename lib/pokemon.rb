require 'pry'

class Pokemon

    attr_accessor :id, :name, :type, :db, :hp
    def initialize (id:, name:, type:, db:, hp:nil)
        @id = id
        @name = name
        @type = type
        @database = db
        @hp = hp
    end

    def self.save(name,type,database)
        sql = <<-SQL
        INSERT INTO pokemon (name, type) VALUES (?,?)
        SQL

        database.execute(sql,name,type)
        
    end

    def self.find(id,database)
        sql = <<-SQL
        SELECT * FROM pokemon WHERE id = ?
        SQL

        row = database.execute(sql,id)
        row = row[0]
        new_object = self.new(id:row[0],name:row[1],type:row[2],db:database)
    end

    def alter_hp(hp, database)
        sql = <<-SQL
        UPDATE pokemon SET hp = ?
        WHERE id = ?
        SQL
        
        database.execute(sql, hp,self.id)
        self.hp = hp
    end




end
