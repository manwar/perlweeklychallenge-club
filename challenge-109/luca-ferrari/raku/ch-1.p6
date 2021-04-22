#!perl6

#
# C(n) = sum of divisors of n except 1 and n
# 
sub choowla( Int $n where { $n > 0 } ) {
    # special case
    return 0 if $n < 2;

    # get all divisors
    # my @divisors.push: $_ if $n %% $_ for 2 .. $n / 2;
    # return [+] @divisors;
    return [+] ( $_ if $n %% $_ for 2 .. $n / 2 );
}

sub MAIN( Int $limit = 20 ) {
    # my @choowla-numbers.push: choowla( $_ ) for 1 .. $limit;
    # @choowla-numbers.join( ',' ).say;
    @( choowla( $_ ) for 1 .. $limit ).join( ',' ).say;
}
