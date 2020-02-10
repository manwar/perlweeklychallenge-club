#!/usr/bin/env perl6

use v6.d;

# Cribbing my code from challenge 10
# Note that I'm skipping the Unicode values this time for size mostly
subset RomanStr of Str where * ~~ /^ <[M C D X L V I]>+ $/;
subset RomanInt of Int where 0 < * < 3001; 
subset Operator of Str where * ~~ /^ ( "*" | "+" | "-" | "/" ) $ /;

#| Given two roman numerals and an operation on them
#| produce the result.
#| Note that division only works where the first value is greater than the second.
#| Results over 3000 and non valid numerals will return an error
multi sub MAIN (
    RomanStr $i, Operator $operator, RomanStr $j
) {
    say "$i $operator $j = {perf-op( $operator, $i, $j )}";
}

#| Single String of operation to parse
multi sub MAIN (
    Str $compound where m!^ (<[M C D X L V I]>+)  " "? ( "*" | "+" | "-" | "/" ) " "? (<[M C D X L V I]>+) $!;
) {
    MAIN( $0.Str, $1.Str, $2.Str );
}

multi sub perf-op( "+", RomanStr $i, RomanStr $j ) {
    to-roman( from-roman($i) + from-roman($j) );
}

multi sub perf-op( "-", RomanStr $i, RomanStr $j ) {
    to-roman( from-roman($i) - from-roman($j) );
}

multi sub perf-op( "*", RomanStr $i, RomanStr $j ) {
    to-roman( from-roman($i) * from-roman($j) );
}

multi sub perf-op( "/", RomanStr $i, RomanStr $j where { from-roman($i) > from-roman($j) } ) {
    my $res = from-roman($i) div from-roman($j);
    my $rem = from-roman($i) % from-roman($j);
    to-roman($res) ~ ( $rem ?? " remainder {to-roman($rem)}" !! "" );
}

multi sub perf-op(*@){ die "Invalid operation. Did you try and create a fraction?" }

sub to-roman (RomanInt $number is copy) {
    my $out = "";
    my @values = ( :1000M, :900CM, :500D, :400CD, :100C, :90XC, :50L, :40XL, :10X, :9IX, :5V, :4IV, :1I );
    for @values -> $pair {
        my ( $sigil, $num ) = $pair.kv;
        while ( $number >= $num ) {
            $out ~= $sigil;
            $number -= $num;
        }
    }
    
    $out;
}

sub from-roman( RomanStr $roman is copy ) {
    my %roman-map = (:1000M, :900CM, :500D, :400CD, :100C, :90XC, :50L, :40XL, :10X, :9IX, :5V, :4IV, :1I );

    my $out = 0;
    while my $match = $roman ~~ s!^ "M" | "CM" | "D" | "CD" | 
                                    "C" | "XC" | "L" | "XL" |
                                    "X" | "IX" | "V" | "IV" | "I"
                                    !! {
        $out += %roman-map{$match};
    }
    $out;
}
