#!/usr/bin/perl6

sub isSmooth(Int $num) {

    # get the divisors that _aren't_ multiples of 2, 3, or 5
    my @divisors = (1 .. $num)
                   .grep( { $num % $_ == 0 } )
                   .grep( { ($_ % 2 != 0) && ($_ % 3 != 0) && ($_% 5 != 0) } );

    # 1 is always a divisor so the array will always have atleast one member.
    return @divisors.elems == 1;
}



multi sub MAIN(
    Int $max #= search for 5-smooth numbers in the range 1 .. max
    ) {
    (1 .. $max).grep(&isSmooth).join(' ').say;
}


