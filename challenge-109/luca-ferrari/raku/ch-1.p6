#!perl6

#
# C(n) = sum of divisors of n except 1 and n
# 
sub choowla( Int $n ) {
    # get all divisors

    my @divisors;
    for 2 .. $n / 2 {
        @divisors.push: $_ if $n %% $_;
    }

    return [+] @divisors;
}

sub MAIN( Int $limit = 20 ) {
    my @choowla-numbers.push: choowla( $_ ) for 1 .. $limit;
    @choowla-numbers.join( ',' ).say;
}
