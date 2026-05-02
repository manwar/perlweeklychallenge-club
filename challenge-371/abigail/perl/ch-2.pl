#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    my @numbers = split;
    #
    # Iterate over all masks, except all 0s and all 1s
    #
    foreach my $mask (1 .. 2 ** @numbers - 2) {
        my $sum;
        my @set;
        while (my ($index, $val) = each @numbers) {
            #
            # If the position is in the mask, add the difference between
            # the number and its position to the sum, and add the number
            # to the current set
            #
            if ($mask & (1 << $index)) {
                $sum += $val - $index - 1;
                push @set => $val;
            }
        }
        #
        # If the sum is 0, and we have more than one element in the set,
        # print the set
        #
        if ($sum == 0 && @set > 1) {
            print "@set; ";
        }
    }
    print "\n";
}

__END__
