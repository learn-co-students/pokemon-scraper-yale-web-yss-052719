class Pokemon

  attr_accessor :id, :name, :type, :db, :hp

  def initialize(attributes)
    attributes.each {|key, value| self.send("#{key}=", value)}
  end

  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO pokemon(name, type)
    VALUES(?,?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
    SELECT * FROM pokemon
    WHERE id=?
    SQL
    row = db.execute(sql, id).first
    Pokemon.new(id: row[0], name: row[1], type: row[2], db: db, hp: row[3])
  end

  def alter_hp(hp, db)
    sql = <<-SQL
    UPDATE pokemon SET hp=?
    WHERE id=?
    SQL
    db.execute(sql, hp, self.id)
  end

end
