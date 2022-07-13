#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-07-12
# Challenge 173 Esthetic Number ( Ruby )

def is_esthetic? ( num )

  arr = num.digits
  prev = arr[0]
  i = 1;

  while ( i < arr.length() )

    if (arr[i] - prev).abs == 1
      prev = arr[i]
      i += 1
    else
      return -1
    end             # if
   end              # while

  return 1

end                 # def

for e in (100..5000) do

retval = is_esthetic? ( e )

if retval == 1

  print"#{e} "

end

end

puts " "
