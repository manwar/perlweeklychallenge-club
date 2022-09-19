#!/usr/bin/perl
use 5.030;
use warnings;
use utf8;
use Math::Complex qw/ Im Re pi /;
use Math::Round qw/ nearest /;
use constant ε => 1e-7;

sub dropImaginary {
    my ($z) = @_;

    if (abs(Im($z)) < ε) {
        $z = Re($z);
    }

    return $z;
}

sub Γ {
    my ($z) = @_;
    $z = Math::Complex->new($z);

    if (Re($z) <  .5) {
        return pi / sin(pi * $z) / Γ(1 - $z);
    } else {
        my @coefficients = qw/
            676.5203681218851
            -1259.1392167224028
            771.32342877765313
            -176.61502916214059
            12.507343278686905
            -0.13857109526572012
            9.9843695780195716e-6
            1.5056327351493116e-7
        /;
        $z -= 1;
        my $sum = 0.99999999999980993;
        my $i =  0;
        for my $c (@coefficients) {
            $sum += $c / ($z + 1 + $i++);
        }
        my $t = $z + scalar @coefficients - 0.5;
        return dropImaginary(sqrt(2 * pi) * $t ** ($z + 0.5) * exp(-$t) * $sum);
    }
}

for my $i (3, 5, 7) {
    say nearest(0.01, Γ($i)); 
}
