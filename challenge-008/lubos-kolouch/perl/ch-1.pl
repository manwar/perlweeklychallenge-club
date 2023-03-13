use strict;
use warnings;

sub is_prime {
    my $num = shift;
    return 0 if ( $num < 2 );
    for ( my $i = 2 ; $i <= sqrt($num) ; $i++ ) {
        return 0 if ( $num % $i == 0 );
    }
    return 1;
}

sub get_next_prime {
    my $num = shift;
    $num++;
    while ( !is_prime($num) ) {
        $num++;
    }
    return $num;
}

my @perfect_numbers = ();
my $p               = 2;
my $num             = 2**( $p - 1 ) * ( 2**$p - 1 );
while ( scalar(@perfect_numbers) < 5 ) {
    push @perfect_numbers, $num;
    $p   = get_next_prime($p);
    $num = 2**( $p - 1 ) * ( 2**$p - 1 );
}

print "The first five perfect numbers are: ";
print join( ", ", @perfect_numbers );
