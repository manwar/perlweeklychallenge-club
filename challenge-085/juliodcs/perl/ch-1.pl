use strict;
use warnings;
use feature 'say';
use experimental 'signatures';
use List::Util 'sum0';

sub triplet(@R) {
    return 0 if @R < 3;
    
    my $sum = sum0((sort { $a cmp $b } @R)[0..2]);

    return $sum > 1 && $sum < 2;
}

if (@ARGV > 0) {
    say triplet(@ARGV);
    exit 0;
}

use Test::More;

ok !triplet(), 'Empty array cannot make triplet';
ok !triplet(1), 'One element cannot make triplet';
ok !triplet(1, 2), 'Two elements cannot make triplet';
ok  triplet(1.5, 0, 0), 'Simple triplet';
ok  triplet(0, 2, 3, 4, 5, 6, 7, 8, 9, 1.5, 0), 'Simple triplet with many numbers';
ok  triplet(1.2, 0.4, 0.1, 2.5), 'Test case 1';
ok !triplet(0.2, 1.5, 0.9, 1.1), 'Test case 2';
ok  triplet(0.5, 1.1, 0.3, 0.7), 'Test case 3';

done_testing;
