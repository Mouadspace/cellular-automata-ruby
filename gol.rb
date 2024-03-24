
ROWS  = 20 
COLS  = 30 
SLEEP = 0.1

LIVE_IMG = "😋"
DEAD_IMG = "🫥"

class Cell 
  LIVE = :LIVE #  'LIVE_IMG'
  DEAD = :DEAD #  'DEAD_IMG'
end
Cell.freeze

class Grid
  attr_accessor :cells  
  def initialize r,c 
    @cells = []
    @rows  = r 
    @cols  = c
    init    
  end
  
  def init 
    @rows.times do |i|
      @cols.times do |j| 
        # initialize random dead and live cells on the grid  
        rand = rand 10 
        @cells.push rand % 5 == 0 ? Cell::LIVE : Cell::DEAD 
      end
    end 
  end

  def render 
    @rows.times do |i|
      @cols.times do |j| 
        if @cells[i * @rows + j] == Cell::LIVE
          print LIVE_IMG 
        else 
          print DEAD_IMG
        end 
      end 
      puts 
    end
  end 

  def get_neighbours r,c 
    neighbours_count = 0 

    for i in -1..1 
      for j in -1..1 
        if i == j and i == 0 
          next  
        end 

        index   = ((r + i) % @rows)*@rows + ((c + j) % @cols)  
        if @cells[index] == Cell::LIVE   
          neighbours_count += 1 
        end 
      end
    end 
    return neighbours_count
  end 

  def next_gen 
    next_cells = []
    @rows.times do |i| 
      @cols.times do |j| 
        neighbours   = get_neighbours i,j 
        c            = i * @rows + j
        cell         = @cells[c]
        if (cell == Cell::LIVE) && ([2,3].include? neighbours) 
          next_cells[c] = Cell::LIVE
        elsif (cell == Cell::DEAD && neighbours == 3) 
          next_cells[c] = Cell::LIVE
        else 
          next_cells[c] = Cell::DEAD
        end 
      end
    end
    @cells = next_cells
  end 



end

if __FILE__ == $0
  gol = Grid.new ROWS,COLS 
  while true do  
    gol.render
    print "\033[#{ROWS}A" 
    gol.next_gen 
    sleep SLEEP
  end
  print "\033[#{ROWS+1}B"
end 
