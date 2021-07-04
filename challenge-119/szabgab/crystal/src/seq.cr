def seq(&block)
  val = 0
  loop do
    val += 1
    next if val.to_s =~ /[04-9]|11/
    yield val
  end
end

def seq(n : Int32) : Int32
  seq {|num|
    n -= 1
    return num if n <= 0
  }
end
