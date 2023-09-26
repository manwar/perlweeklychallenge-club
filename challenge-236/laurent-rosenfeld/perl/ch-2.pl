use strict;
use warnings;
use feature 'say';

sub find_loops {
    my @in = @_;
    my $count = 0;
    for my $i (0..$#in) {
        my $j = $i;
        # say $i;
        while (1) {
            last unless defined $in[$j];
            # say "\t", $j, "\t", @in[$j];
            ++$count and last if $in[$j] == $i;
            $j = $in[$j];
        }
    }
    return $count;
}

