#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-05-24
# Challeng 166 Hexadecimal Words ( Julia )

letters = Dict( "a"=>"a","b"=>"b", "c"=>"c","d"=>"d","e"=>"e","f"=>"f","o"=>"0","l"=>"1", "i"=>"1", "s"=>"5","t"=>"7" )

function checkArgs(args)
  global num

  try
    num = parse(Int64, args[1])
  catch
    println("Error: Argument must be an integer")
    exit(0)
  finally
    if num < 2 || num > 8
      println("Error: Argument must be 2 <= n <= 8")
      exit(0)
    else
      main(num)
    end
  end
end

function tr(str, reps...)
  d = Dict(reps)
  return(map(s -> get(d,s,s), str))
end

function main(selection)
  open("Words.txt") do f
    while ! eof(f)
       s = readline(f)
       found = 0
       s = strip(s)
       s = lowercase(s)

       if length(s) == selection
        arr = split(s,"")
          for i in (arr)
            if (haskey(letters, i))
              found += 1
            end
          end

          if found == selection
            s = tr(s,'o'=>'0','l'=>'1','i'=>'1','s'=>'5','t'=>'7')
            print("$s ")
          end
       end
    end

    close(f)
  end
end

checkArgs(ARGS)
