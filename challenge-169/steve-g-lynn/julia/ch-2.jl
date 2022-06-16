#!/usr/bin/julia

using Primes

ctr=1;

for i in (2:2000)
           Freq=values(factor(Dict,i))
           
           # julia stores the factors as a hash-like object of the form
           # factor{frequency} in perl notation (coerced to regular 
           # julia hash aka Dict here)
           # values(..) retrieves the values in the key-value pairs 
           # (number of times each factor is repeated)
           
           #-- skip if only one factor
           if (length(Freq)==1)
               continue
           end
           
           #-- skip if any factor occurs less than twice
           if ((Freq .< 2)!=zeros(length(Freq)))
               continue # next
           end
           
           #-- achilles' heel: gcd of Freq should be 1; skip otherwise
           if (gcd(Freq .+ 0) > 1) # .+ 0 to coerce Freq to array
               continue
           end
           
           print("$i ")
           global ctr=ctr+1
           
           if (ctr > 20)
           	break
           end
       end

println("")


