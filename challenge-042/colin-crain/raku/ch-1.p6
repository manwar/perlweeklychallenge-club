use v6;

#
#       octal.p6
#
#       PWC 42 - Task #1
#       Octal Number System
#             Write a script to print decimal number 0 to 50 in Octal Number System.
#
#             For example:
#
#             Decimal 0 = Octal 0
#             Decimal 1 = Octal 1
#             Decimal 2 = Octal 2
#             Decimal 3 = Octal 3
#             Decimal 4 = Octal 4
#             Decimal 5 = Octal 5
#             Decimal 6 = Octal 6
#             Decimal 7 = Octal 7
#             Decimal 8 = Octal 10
#             and so on.
#
#        method: the algorithm out of the box works for N, as any positive
#             integer can be essentially recounted in a different base. It can
#             be expanded to Z by keeping track of a 'sign bit', converting the
#             absolute value and adding back the sign to the output as
#             required. Rational numbers, Q, are where things get tricky. In
#             cases where the set of prime factors of the two number systems
#             are not the same, repeating fractions become an unfortunate
#             reality.
#
#             Specifically whether the pet of prime factors of the new base are a
#             subset of that of the old. So any number base8 {2} can be expressed
#             base10 {2,5} but not vice versa.
#                                          ____
#             For example 0.1 base10 = 0.0[6314] base8
#
#             For this reason we will not consider Q for the moment. And R, Real
#             numbers, including π and e and such, is just right out. Even
#             though it isn't required for the challenge as stated, we will
#             construct an algorithm that will handle negative numbers
#             properly.
#
#             It follows that any binary representation of a number can be
#             converted into an octal, or hexadecimal, equivalent without losing
#             any precision, as the only factors of these bases are in the set
#             {2}. This is in fact specifically why they are convenient; unique
#             combinations of 4 binary, 2 octal and 1 hexadecimal digits are
#             directly mappable from one system to the other without any
#             knowledge of the number, or part of a number, that they represent.
#             The higher number bases serve as a convenient shorthand for
#             sections of much harder for humans to read binary streams.
#
#             We will use integer division to divide out the number by 8s. When
#             we realize the graphemes we use to represent a number, no matter
#             what base we use, are not really the number but a rather a
#             representation of that number using marks, we can create the new
#             number much as we would write it on a page. Each time we divide
#             out we reset the number to floor(n/d) and write the remainder to
#             the front of our output. Adding a special case for 0 and we have
#             created a string that Perl can parse as a number, which it is, as
#             much as writing the same on a page is that number. Perl is good
#             like that.

#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN () {

    for -50 .. 50 {
        printf "Decimal %3d = Octal %3d\n", $_, octal($_) ;
    }
}


## ## ## ## ## SUBS

sub octal ( $dec is copy ){
    my $out = "";
    my $sign = $dec < 0 ?? "-" !! "";
    $dec .= abs;
    my $rem;
    while ( $dec > 0 ) {
        $rem = $dec % 8;
        $dec = ($dec/8).floor;
        $out = $rem ~ $out;
    }
    $out = $sign ~ $out;
    return $out ?? $out !! 0;  ## needs to output 0 for 0
}
