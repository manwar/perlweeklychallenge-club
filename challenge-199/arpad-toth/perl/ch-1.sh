# https://theweeklychallenge.org/blog/perl-weekly-challenge-199/
# challenge #1
# quick one-liner

# example 1:
perl -E '$i=$c=0;while($i<=$#ARGV){for($i..$#ARGV){$c++ if $ARGV[$i]==$ARGV[$_+1]};$i++;};say $c' 1 2 3 1 1 3
# output: 4

# example 2:
perl -E '$i=$c=0;while($i<=$#ARGV){for($i..$#ARGV){$c++ if $ARGV[$i]==$ARGV[$_+1]};$i++;};say $c' 1 2 3
# output: 0

# example 3:
perl -E '$i=$c=0;while($i<=$#ARGV){for($i..$#ARGV){$c++ if $ARGV[$i]==$ARGV[$_+1]};$i++;};say $c' 1 1 1 1
# output: 6
