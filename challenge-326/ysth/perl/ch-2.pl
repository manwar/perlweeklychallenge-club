use 5.040;

my @ints = @ARGV;

# a couple of ways:

my @out;
for my ($i, $j) (@ints) {
    push @out, ($j) x $i;
}
say "@out";

use List::Util 1.29 'pairmap';
@out = pairmap { ($b) x $a } @ints;
say "@out";
