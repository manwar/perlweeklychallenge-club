use strict;
use warnings;
use feature "say";

sub compute_dec_str {
    my ($num, $den) = @_;
    die "Please provide positive numbers" if $num < 0 or $den <= 0;
    my $c = 10 * ($num % $den);
    my $quotient = $num/$den;
    # get the quotient leading 0s if any
    $quotient =~ s/(^\d+\.?0*)\d*/$1/;
    $c *= 10 for split " ",  ($quotient =~ /\.(0+)/);
    my (@digits, %passed);
    my $i = 0;
    while (1) {
        if (exists $passed{$c}) {
            my @repeated = @digits[$passed{$c}..$#digits];
            my $result = $quotient . join("", @digits[0..$passed{$c} - 1]);
            if ( @repeated > 1 or $repeated[0] != 0) {
                $result .= "(" . join("", @repeated) . ")";
            }
            $result =~ s/\.$//; # remove trailing dot if any
            return $result;
        }
        push @digits, int($c / $den);
        $passed{$c} = $i;
        $i++;
        $c = 10 * ($c % $den);
    }
}
my $result = compute_dec_str @ARGV;
say $result;
