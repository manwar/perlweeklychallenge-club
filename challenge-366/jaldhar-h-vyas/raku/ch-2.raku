#!/usr/bin/raku

sub MAIN(
    Str $time
) {
    my $possibilities = 0;
    my ($hourTens, $hourOnes, (), $minuteTens, $minuteOnes) = $time.comb;

    if $hourTens eq q{?} && $hourOnes eq q{?} {
        $possibilities = 24;
    } elsif $hourTens eq q{?} {
        $possibilities = ($hourOnes ~~ 0 .. 3) ?? 3 !! 2; 
    } elsif $hourOnes eq q{?} {
        $possibilities = ($hourTens == 2) ?? 4 !! 10;
    } else {
        $possibilities = 1;

    }
    if $minuteTens eq q{?} && $minuteOnes eq q{?} {
        $possibilities *= 60;
    } elsif $minuteTens eq q{?} {
        $possibilities *= 6; 
    } elsif $minuteOnes eq q{?} {
        $possibilities *= 10;
    } else {
        if $possibilities == 1 {
            $possibilities = 0;
        }
    }

    say $possibilities;
}
