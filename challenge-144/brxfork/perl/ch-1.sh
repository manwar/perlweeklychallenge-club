#!/bin/sh
perl -E 'while (++$n <= 100) {undef @pf ; $_="S" x $n ; m{^(S{2,}?)(??{ $1=~/^(S{2,})\1+$/?"(?!)":"" })\1+$(?{push @pf, length($1)})(?!)};next if (@pf<1 or @pf>2 or ($pf[0]*($pf[1]//$pf[0])!=$n)) ;print "$n is Semiprime as $n = $pf[0] x ",$pf[1]//$pf[0],"\n"}'
#
# Default variable $_ contains several "S" (exactly $n chars).  
# 
# 1) 
# m{^(S{2,}?)(??{ $1=~/^(S{2,})\1+$/?"(?!)":"" })\1+$(?{push @pf, length($1)})(?!)}
#   ---------                                    ---- 
# 
# This finds any factor of $n by capturing a sequence in $1 (factor == length($1) )
#   for example it finds "SSS" in "SSSSSS" (3 is a factor of 6 :)
#   
# 2) 
# m{^(S{2,}?)(??{ $1=~/^(S{2,})\1+$/?"(?!)":"" })\1+$(?{push @pf, length($1)})(?!)}
#             ----------------------------------
#        Here we verified the factor is a prime number 
# (??{}) produces a pattern "(?!)" if $1 is not prime => always fail => backtracking
# (??{}) produces a pattern "" if $1 is prime => always ok => continue 
# 
# 3)
# m{^(S{2,}?)(??{ $1=~/^(S{2,})\1+$/?"(?!)":"" })\1+$(?{push @pf, length($1)})(?!)}
#                                                    -------------------------
#  When a prime factor is found, we keep it in @pf
#
# 4)
# m{^(S{2,}?)(??{ $1=~/^(S{2,})\1+$/?"(?!)":"" })\1+$(?{push @pf, length($1)})(?!)}
#                                                                             ----
# This pattern always fails. Backtracking permits to find all prime factors.
#
# Result : we keep only numbers with exactly one or two prime factors
# and we verify the product is correct (the square if only one prime factor).
# So we don't keep 8 because 2*2!=8
