use strict;
use warnings;
use feature 'say';

sub two_out_of_three {
    my %histo;
    for my $in (@_) {
        my %temp = map {$_ => 1} @$in; # make items unique
        $histo{$_} += 1 for keys %temp;
    }
    return sort grep { $histo{$_} >= 2 } keys %histo;
}
for my $test ( [ [1, 1, 2, 4], [2, 4], [4] ],
      [ [4, 1], [2, 4], [1, 2] ] ) {
    print "(@$_) " for @$test;
    say " => ", join " ", two_out_of_three (@$test);
}
