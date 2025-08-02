#!/usr/bin/perl
use 5.030;
use warnings;

sub isRREF {
    my ($matrix) = @_;
    my $leading = -1;
    my $zeroRow = undef;

    for my $row (keys @{$matrix}) {
        my $currentLeading = -1;
        for my $col (keys @{$matrix->[$row]}) {
            if ($matrix->[$row][$col] == 1) {
                $currentLeading = $col;
                last;
            }
        }

        if ($currentLeading == -1) {
            if (grep { $_ > 1 } @{$matrix->[$row]}) {
                return 0;
            }

            $zeroRow = 1;
            next;
        }
        
        if ($zeroRow) {
            return 0;
        }

        if ($currentLeading < $leading) {
            return 0;
        }

        $leading = $currentLeading;

        if ((scalar grep { $_ > 0 } map { $matrix->[$_][$leading] } keys @{$matrix}) > 1) {
            return 0;
        }
    }
    
    return 1;
}

my @matrix = map { [ map { 0 + $_ } split /\s+/ ] } @ARGV;

say isRREF(\@matrix);
