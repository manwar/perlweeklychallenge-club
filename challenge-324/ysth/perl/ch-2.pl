use 5.036;
use List::Util 'sum';

my @ints = grep !/\D/a, @ARGV;
die "expected list of integers\n" if @ints != @ARGV;

say sum map eval, glob 0 . join '', map "{^$_,}", @ints;
