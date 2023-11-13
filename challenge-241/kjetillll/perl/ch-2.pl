use warnings; use strict;

#use Math::Prime::Util 'factor' #...or this simpler but suboptimal one:

sub factor { #returns the list of an ints prime factors
    my($n) = @_;
    my $factor;
    $n % $_ == 0 and $factor = $_ and last for 2 .. sqrt $n;
    $factor ? ( $factor, factor($n/$factor) ) : $n
}

sub number_of_prime_factors { my @factor = factor(@_); scalar @factor }

sub prime_order {
    map $$_{value},
    sort {
      $$a{sort_by} <=> $$b{sort_by} or
      $$a{value}   <=> $$b{value}
    }
    map {value=>$_, sort_by=>number_of_prime_factors($_)},
    @_
}

for my $test (
    {
        input           => [11, 8, 27, 4],
        output_expected => [11, 4, 8, 27]
    },
    {
        input           => [
            2 * 3 * 4 * 5, #120
            2 ** 8,        #256
            7 * 7 * 7,     #343
            3 * 7 * 11,    #231
            2 * 7 * 13,    #182
            19 * 23,       #437
            ],
        output_expected => [437, 182,231,343,120,256]
    }
){
    my @output_got = prime_order( @{ $$test{input} } );
    print "@output_got" eq "@{ $$test{output_expected} }"
                        ? 'ok'
                        : 'NOT OK';
    print "  got: @output_got\n";
}
