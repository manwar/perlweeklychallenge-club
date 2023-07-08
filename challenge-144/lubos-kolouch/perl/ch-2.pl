use strict;
use warnings;

sub ulam_sequence {
    my ( $u, $v, $n ) = @_;
    $n //= 10;
    my @sequence = ( $u, $v );
    while ( @sequence < $n ) {
        my %sums;
        for my $i ( 0 .. $#sequence ) {
            for my $j ( $i + 1 .. $#sequence ) {
                $sums{ $sequence[$i] + $sequence[$j] }++;
            }
        }
        my $next_val = ( sort { $a <=> $b }
              grep { $sums{$_} == 1 and $_ > $sequence[-1] } keys %sums )[0];
        push @sequence, $next_val;
    }
    return @sequence;
}

print join( ", ", ulam_sequence( 1, 2 ) ), "\n";
print join( ", ", ulam_sequence( 2, 3 ) ), "\n";
print join( ", ", ulam_sequence( 2, 5 ) ), "\n";
