#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-05-24
# Challenge 166 Hexadecimal Words ( Ruby )

letters =  { 'a'=>"a",'b'=>"b",'c'=>"c",'d'=>"d",'e'=>"e",'f'=>"f",'o'=>"0",'l'=>"1",'i'=>"1",'s'=>"5",'t'=>"7" };
selection = 0;

for selection in ARGV
  selection = selection.to_i

  if (selection < 2  or selection > 8 )
    puts "Selection must be >= 2 and <= 8"
    exit
  end
end

File.foreach("Words.txt") { |line|
  line = line.lstrip.rstrip.downcase

  if line.size != selection
    next
  end

  @arr = line.split("")
  found = 0

  for letter in @arr
    if letters[letter]
      found = found + 1
      if (found == selection)
        line = line.tr('olist','01157')
        print "#{line} "
        STDOUT.flush
      end
    end
  end
}
