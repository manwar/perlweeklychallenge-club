#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

subset RomanInt of Int where 0 < * < 3001; 
subset RomanStr of Str where * ~~ /^ <[M C D X L V I Ⅿ Ⅽ Ⅾ Ⅹ Ⅼ Ⅴ Ⅰ Ⅻ Ⅺ Ⅸ Ⅷ Ⅶ Ⅵ Ⅳ Ⅲ Ⅱ]>+ $/;

sub to-roman (RomanInt $number is copy, @values) {
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

sub from-roman( RomanStr $roman is copy ) {
    my %roman-map = (
        "M" => 1000,
        "Ⅿ" => 1000,
        "CM" => 900,
        "ⅭⅯ" => 900,
        "D" => 500,
        "Ⅾ" => 500,       
        "CD" => 400,
        "ⅭⅮ" => 400,
        "C" => 100,
        "Ⅽ" => 100,
        "XC" => 90,
        "ⅩⅭ" => 90,
        "L" => 50,
        "Ⅼ" => 50,
        "XL" => 40,
        "ⅩⅬ" => 40,
        "Ⅻ" => 12,
        "Ⅺ" => 11,
        "X" => 10,
        "Ⅹ" => 10,
        "Ⅸ" => 9,
        "IX" => 9,  
        "ⅠⅩ" => 9,
        "Ⅷ" => 8, 
        "Ⅶ" => 7,
        "Ⅵ" => 6,
        "VI" => 6,
        "ⅤⅠ" => 6,
        "V" => 5,
        "Ⅴ" => 5,
        "Ⅳ" => 4,
        "IV" => 4,
        "ⅠⅤ" => 4,
        "Ⅲ" => 3,
        "Ⅱ" => 2, 
        "I" => 1,
        "Ⅰ"  => 1,
    );

    my $out = 0;
    while my $match = $roman ~~ s!^ "M" | "Ⅿ" | 
                                      "CM" | "ⅭⅯ" | 
                                      "D" | "Ⅾ" | 
                                      "CD" | "ⅭⅮ" | 
                                      "C" | "Ⅽ" | 
                                      "XC" | "ⅩⅭ" |
                                      "L" | "Ⅼ" | 
                                      "XL" | "ⅩⅬ" |
                                      "Ⅻ" | "Ⅺ" | 
                                      "X" | "Ⅹ" |
                                      "Ⅸ" | "IX" | "ⅠⅩ" |
                                      "Ⅷ" | "Ⅶ" |
                                      "Ⅵ" | "VI" | "ⅤⅠ" |
                                      "V" | "Ⅴ" |
                                      "Ⅳ" | "IV" | "ⅠⅤ" |
                                      "Ⅲ" | "Ⅱ" |
                                      "I" | "Ⅰ" !! {
        $out += %roman-map{$match};
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

#| Print the arabic version of the roman numeral string
multi sub MAIN(
    RomanStr $roman #= Roman numeral string to convert
) {
    say from-roman( $roman );
}