

WIDTH = 40
RULE  = 22 

rule  = RULE.to_s(2)   #    10110
rule  = "000" + rule   # 00010110
rule  = rule.reverse 
LIVE_IMG = "O"
DEAD_IMG = "."

class Cell 
  LIVE = 1 
  DEAD = 0
end
Cell.freeze 

class Row 
  def initialize width, rule 
    @rule  = rule
    @width = width
    @row   = [] 
    init_row
  end

  def init_row
    @width.times do 
      @row.push Cell::DEAD
    end
    @row[(@width / 2).floor] = Cell::LIVE
  end

  def render 
    @row.length.times do |i| 
      if @row[i] == Cell::LIVE 
        print LIVE_IMG
      else 
        print DEAD_IMG
      end
    end 
    puts 
  end
  
  def next_gen 
    next_row = []
    next_row.push Cell::DEAD
    (@width - 2).times do |i| 
      index = @row[i].to_s + @row[i+1].to_s + @row[i+2].to_s 
      index = index.to_i 2
      next_row[i+1] = @rule[index].to_i  
    end
    next_row.push Cell::DEAD
    @row = next_row
  end



end 

row = Row.new WIDTH, rule  

while true 
  row.render
  row.next_gen
  sleep 0.5
end


