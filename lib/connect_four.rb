class Game
  def initialize
    @board = [
      [",,",",,",",,",",,",",,",",,",",,"],
      [",,",",,",",,",",,",",,",",,",",,"],
      [",,",",,",",,",",,",",,",",,",",,"],
      [",,",",,",",,",",,",",,",",,",",,"],
      [",,",",,",",,",",,",",,",",,",",,"],
      [",,",",,",",,",",,",",,",",,",",,"],
      ]
    @symbol="⚪"
    @game_done=false
  end

  public
  def play
    display
    until @game_done==true do
      print "Player #{@symbol}'s turn, pick a X coordinate to place: "
      ans = gets.chop.to_i-1
      place(ans)
    end
  end

  def place(x)
    return false if (x<0 or x>6)
    symbol_to_place = @symbol
    y=0
    y+=1 until (y==6 or @board[y][x]==",,")
    return false if (y==6)

    ## On success
    @board[y][x]=symbol_to_place
    display()

    if winning_move?(y,x)                  ##Should return true
      end_game()
      return true
    end
    change_symbol()
    return [ [y,x] , symbol_to_place ]        ##Otherwise, return placement in this format
  end

  private
  def change_symbol
    if @symbol=="⚪"
      @symbol="⚫"
    else 
      @symbol="⚪"
    end
  end

  def display
    @board.reverse.each {|row| puts row.join(" ") }
    puts ["1","2","3","4","5","6","7"].join("  ")
    puts ""
  end

  def winning_move?(y,x)
    return true if count_horizontal_same(y,x)>3
    return true if count_vertical_same(y,x)>3
    return true if count_diagonal_same(y,x)>3
  end

  ##  Could definitely wrap these counting methods 
  ##  into something and more modular

  def count_horizontal_same(y,x)
    symbol=@board[y][x]
    sum=1 
    cur_x=x-1
    until (cur_x==-1 || @board[y][cur_x]!=symbol)
      cur_x-=1
      sum+=1
    end

    cur_x=x+1
    until (cur_x==7 || @board[y][cur_x]!=symbol)
      cur_x+=1
      sum+=1
    end
    sum
  end

  def count_vertical_same(y,x)
    symbol = @board[y][x]
    sum=1
    cur_y=y-1
    until ( cur_y==-1 || @board[cur_y][x]!=symbol)
      cur_y-=1
      sum+=1
    end
    sum
  end

  def count_diagonal_same(y,x)
    symbol = @board[y][x]
    sum=1
    cur_y=y-1
    cur_x=x-1
    until (cur_y==-1 || cur_x==-1 || @board[cur_y][cur_x]!=symbol)
      cur_y-=1
      cur_x-=1
      sum+=1
    end

    cur_y=y+1
    cur_x=x+1
    until (cur_y==6 || cur_x==7 || @board[cur_y][cur_x]!=symbol)
      cur_y+=1
      cur_x+=1
      sum+=1
    end
    sum
  end

  def end_game
    puts "ENDING GAME"
    puts "CONGRATULATIONS TO PLAYER #{@symbol}"
    @game_done=true
    true
  end
end

#   TO PLAY
#   -------
#
#   game = Game.new
#   game.play