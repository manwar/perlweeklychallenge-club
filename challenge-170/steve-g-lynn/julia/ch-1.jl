#!/usr/bin/julia

using Primes

function nth_prime(n::Int64)
     if (n==0)
       return 1
     else
       prevprime=nth_prime(n-1)
       return nextprime(prevprime+1)
     end
end

function primorial(n::Int64)
   if (n==0)
     return 1
   else
     return nth_prime(n)*primorial(n-1)
   end
end

for i in (0:10)
   print("$(primorial(i)) ")
end

println("")


