#! /usr/bin/crystal

module JumbledLetters
  wordre = Regex.new("([A-Za-z])([A-Za-z][A-Za-z]+)([A-Za-z])")
  begin
    while line = read_line()
      l = line.gsub(wordre) { |_x, s|
        s[1] + jumble(s[2]) + s[3] }
      print("#{l}\n")
    end
  rescue IO::EOFError 
  end
end

def jumble(a : String)
  a.chars().shuffle.join
end
