# https://theweeklychallenge.org/blog/perl-weekly-challenge-199/
# challenge #2
# again a quick one-liner

# example 1:
perl -E '$c=0;$x=7;$y=2;$z=3;$i=0;$j=1;$k=2;while($#ARGV>=0){while($k<=$#ARGV){for($k..$#ARGV){$c++ if(abs($ARGV[$i]-$ARGV[$j])<=$x && abs($ARGV[$j]-$ARGV[$_])<=$y && abs($ARGV[$i]-$ARGV[$_])<=$z)};$j++;$k++};$i=0;$j=1;$k=2;splice(@ARGV,0,1)};say $c' 3 0 1 1 9 7
# output :4

# example 2:
perl -E '$c=0;$x=0;$y=0;$z=1;$i=0;$j=1;$k=2;while($#ARGV>=0){while($k<=$#ARGV){for($k..$#ARGV){$c++ if(abs($ARGV[$i]-$ARGV[$j])<=$x && abs($ARGV[$j]-$ARGV[$_])<=$y && abs($ARGV[$i]-$ARGV[$_])<=$z)};$j++;$k++};$i=0;$j=1;$k=2;splice(@ARGV,0,1)};say $c' 1 1 2 2 3
# output :0
