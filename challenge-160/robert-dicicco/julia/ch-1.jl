#!julia.exe

# AUTHOR
# Robert DiCicco
# DATE: 12-APR-2022
# Challenge 160 Four Is Magic ( Julia )

num_name = Dict( 1 => "One",
                2 => "Two",
                3 => "Three",
                4 => "Four",
                5 => "Five",
                6 => "Six",
                7 => "Seven",
                8 => "Eight",
                9 => "Nine",
                )

function checkArgs(args)
  global num

  try
    num = parse(Int64, args[1])
  catch
    println("Error: Argument must be an integer")
    exit(0)
  finally
    if num <= 0 || num > 9
      println("Error: Argument must be 1 <= n <= 9")
      exit(0)
    else
      main(num)
    end
  end
end

function main(n)
  println("Input: \$n = $n")
  while n != 4
    n_name = get(num_name,n,1)
    len = length(n_name)
    l_name = get(num_name,len,1)
    print("$n_name is $l_name, ")
    n = len
  end

  println("Four is magic.")
end

checkArgs(ARGS)
