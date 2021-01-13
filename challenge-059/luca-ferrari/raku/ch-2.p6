#!env raku

# Helper Function
# 
#     For this task, you will most likely need a function f(a,b)
#     which returns the count of different bits of binary representation of a and b.
# 
#     For example, f(1,3) = 1, since:
# 
#     Binary representation of 1 = 01
# 
#     Binary representation of 3 = 11
# 
#     There is only 1 different bit. Therefore the subroutine should return 1.
#     Note that if one number is longer than the other in binary,
#     the most significant bits of the smaller number are padded (i.e., they are assumed to be zeroes).
#
#
#     Script Output
# 
#     You script should accept n positive numbers.
#     Your script should sum the result of f(a,b) for every pair of numbers given:
# 
#     For example, given 2, 3, 4, the output would be 6, since f(2,3) + f(2,4) + f(3,4) = 1 + 2 + 3 = 6



sub f( Int:D $a, Int:D $b ) {
    my $different-bits = 0;

    my @a-bits = $a.base( 2 ).Str.comb.reverse;
    my @b-bits = $b.base( 2 ).Str.comb.reverse;

    # find the longest number
    my $max-length = max( @a-bits.elems, @b-bits.elems );
    # do the padding with zeros (to the end, the arra)
    @a-bits.push: 0 for 0 .. ( $max-length - @a-bits.elems  );
    @b-bits.push: 0 for 0 .. ( $max-length - @b-bits.elems );


    # compute the difference
    for 0 ..^ @a-bits.elems {
        $different-bits += 1 if ( @a-bits[ $_ ] != @b-bits[ $_ ] );
    }

    $different-bits;
}

################
my $sum = 0;
for 0 ..^ @*ARGS.elems  -> $first {
    for $first + 1 ..^ @*ARGS.elems  -> $second {
        $sum += f( @*ARGS[ $first ].Int, @*ARGS[ $second ].Int );
    }
}
say "Sum is $sum";
