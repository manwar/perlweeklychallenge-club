#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

subset RomanInt of Int where 0 < * < 3001; 

sub to-roman (RomanInt $number is copy, @values) is export {
    my $out = "";

    for @values -> $pair {
        my ( $sigil, $num ) = $pair.kv;
        while ( $number >= $num ) {
            $out ~= $sigil;
            $number -= $num;
        }
    }
        
    $out;
}

#| Help data
multi sub MAIN( :h(:$help) ) {
    say $*USAGE;
} 

#| Print the Roman Numeral version of a number
multi sub MAIN( 
    RomanInt $i, #= Integer value to return as Roman Numeral
    Bool :u(:$unicode) #= Return in Unicode
    ) {
    my @values = ( :1000M, :900CM, :500D, :400CD, :100C, :90XC, :50L, :40XL, :10X, :9IX, :5V, :4IV, :1I );
    if ( $unicode ) {
        @values = ( 
            "Ⅿ" => Ⅿ, "ⅭⅯ" => 900, "Ⅾ" => Ⅾ, "ⅭⅮ" => 400, "Ⅽ" => Ⅽ,
            "ⅩⅭ" => 90, "Ⅼ" => Ⅼ, "ⅩⅬ" => 40, "Ⅹ" => Ⅹ, "Ⅸ" => Ⅸ, 
            "Ⅴ" => Ⅴ, "Ⅳ" => Ⅳ, "Ⅰ" => Ⅰ 
        );
    }

    say to-roman( $i, @values );
}