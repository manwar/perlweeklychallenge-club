use strict;
use warnings;

sub is_prime {
    my $num = shift;
    return 0 if $num < 2;
    for ( my $i = 2 ; $i <= sqrt($num) ; $i++ ) {
        return 0 if $num % $i == 0;
    }
    return 1;
}

sub is_cyclops {
    my $num    = shift;
    my $digits = length($num);
    return 0 if $digits % 2 == 0;
    my $middle = int( $digits / 2 );
    return
         substr( $num, $middle, 1 ) eq '0'
      && substr( $num, 0, $middle ) eq reverse( substr( $num, $middle + 1 ) );
}

sub generate_palindromic_prime_cyclops {
    my $count = shift;
    my @results;
    my $num = 0;

    while ( $count > 0 ) {
        if ( is_cyclops($num) && is_prime($num) ) {
            push @results, $num;
            $count--;
        }
        $num++;
    }

    return @results;
}

# Testing
my @results = generate_palindromic_prime_cyclops(20);
print join( ", ", @results ), "\n";
