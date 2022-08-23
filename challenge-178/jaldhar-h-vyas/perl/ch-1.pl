#!/usr/bin/perl
use 5.030;
use warnings;
use Math::Prime::Util qw/ todigits /;
use POSIX qw/ floor /;

# based on http://www.rosettacode.org/wiki/Negative_base_numbers#Perl
sub quaterImaginaryBase {
    my($n) = @_;
    my @result;
    my $r = 0;

    while ($n) {
        $r = $n % -4;
        $n = floor($n / -4);
        if ($r < 0) {
            $n++;
            $r += 4;
        }
        push @result, todigits($r, 4) || 0;
    }

    return join '0', reverse @result;
}

my ($n) = shift // die "Need an integer\n";

say quaterImaginaryBase($n);