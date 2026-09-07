#! /usr/bin/crystal

def reordernotes(composer, notes, order)
  out = Array.new(order.size, "")
  order.each_with_index do |n, i|
    out[n - 1] = notes[i]
  end
  {composer => out}
end

if reordernotes("Mozart", ["C", "D", "E", "F", "G", "A", "B"], [7, 1, 6, 2, 5, 3, 4]) == { "Mozart" =>  ["D", "F", "A", "B", "G", "E", "C"] }
  print "1 pass\n"
else
  print "1 fail\n"
end
if reordernotes("Chopin", ["C", "C#", "D", "D#", "E", "F"], [6, 5, 4, 3, 2, 1]) == { "Chopin" => ["F", "E", "D#", "D", "C#", "C"] }
  print "2 pass\n"
else
  print "2 fail\n"
end
if reordernotes("Vivaldi", ["A", "B", "C", "D", "E"], [1, 2, 3, 4, 5]) == {"Vivaldi" => ["A", "B", "C", "D", "E"] }
  print "3 pass\n"
else
  print "3 fail\n"
end
if reordernotes("Debussy", ["C", "D", "F", "G", "A"], [1, 3, 5, 2, 4]) == {"Debussy" => ["C", "G", "D", "A", "F"] }
  print "4 pass\n"
else
  print "4 fail\n"
end
if reordernotes("Stravinsky", ["C#"], [1]) == { "Stravinsky" => [ "C#"] }
  print "5 pass\n"
else
  print "5 fail\n"
end
