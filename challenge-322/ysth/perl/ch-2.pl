use 5.036;
use List::Util 'uniq';

my @integers = @ARGV;

my @ordered = sort { $a <=> $b } uniq @integers;
say join ' ', { map(($ordered[$_-1], $_), 1..@ordered) }->@{@integers};
