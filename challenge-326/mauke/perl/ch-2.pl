use v5.36;
use List::Util qw(pairmap);

say join " ", pairmap { ($b) x $a } @ARGV;
