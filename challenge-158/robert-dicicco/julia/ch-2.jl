#!julia.exe

using Printf
using Primes

# AUTHOR: Robert DiCicco
# DATE: 29-MAR-2022
# Challenge 158 Cuban Primes ( Julia )

 function makeCuban( num )

   cuban = ((3 * (num^2)) + (3 * num) + 1)

   if (isprime(cuban))
     return(cuban)
   end

   return(-1)
 end

function main()

  TARGET = 1000
  i = 1

  while true
    retval = makeCuban(i)

    if retval > TARGET
      break
    end

    if retval > 0
       @printf("%d ",retval)
    end

    i += 1
  end

  print("\n")
end



main()
