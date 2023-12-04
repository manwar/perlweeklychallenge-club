# The Weekly Challenge 245
# Task 2 Largest of Three
use v5.30.0;
use warnings;
use List::Util qw/sum min/;

sub lot {
    my @ints = @_;
    my $idr = sum(map {$_ % 3} @ints) % 3;
    if ($idr != 0) {
        my $unwanted2 = -12;
        my $unwanted = min grep {$idr == $_ % 3} @ints;
        my $unwill = 1;
        if (!$unwanted) {
            my @unwants = sort {$a<=>$b} grep {($idr+1) % 3 == $_ % 3} @ints;
            $unwanted = $unwants[0];
            $unwanted2 = $unwants[1];
            return -1 if !$unwanted2;
        }
        my @nints;
        for my $z (@ints) {
            if ($z == $unwanted || $z == $unwanted2) {
                $unwill--;
                $unwanted = -11 if $z == $unwanted;
                $unwanted = -12 if $z == $unwanted2;
            }
            else {
                push @nints, $z;
            }
        }
        return -1 if scalar @nints == 0;
        return join "", sort {$b<=>$a} @nints;
    }
    else {
        return -1 if scalar @ints == 0;
        return join "", sort {$b<=>$a} @ints;
    }
}


use Test::More tests=>7;
ok lot(8,1,9) == 981;
ok lot(8,6,7,1,0) == 8760;
ok lot(1) == -1;
ok lot(1,2) == 21;
ok lot(1,2,2) == 21;
ok lot(2,2) == -1;
ok lot(2,2,3,6,9) == 963;
