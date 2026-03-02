#!/usr/bin/raku

sub numberToEnglish(Int $n) {
    state %ones = (
        0 => 'zero',
        1 => 'one',
        2 => 'two',
        3 => 'three',
        4 => 'four',
        5 => 'five',
        6 => 'six',
        7 => 'seven',
        8 => 'eight',
        9 => 'nine'
    );
    
    state %teens = (
        10 => 'ten',
        11 => 'eleven',
        12 => 'twelve',
        13 => 'thirteen',
        14 => 'fourteen',
        15 => 'fifteen',
        16 => 'sixteen',
        17 => 'seventeen',
        18 => 'eighteen',
        19 => 'nineteen'
    );
    
    state %tens = (
        20 => 'twenty',
        30 => 'thirty',
        40 => 'forty',
        50 => 'fifty', 
        60 => 'sixty',
        70 => 'seventy',
        80 => 'eighty',
        90 => 'ninety'
    );
    
    if $n == 0 {
        return %ones{0};
    }
    
    my $abs = $n.abs;
    my @parts;
    
    if $abs >= 1_000_000_000 {
        @parts.push(numberToEnglish($abs div 1_000_000_000) ~ ' billion');
        $abs %= 1_000_000_000;
    }
    
    if $abs >= 1_000_000 {
        @parts.push(numberToEnglish($abs div 1_000_000) ~ ' million');
        $abs %= 1_000_000;
    }
    
    if $abs >= 1_000 {
        @parts.push(numberToEnglish($abs div 1_000) ~ ' thousand');
        $abs %= 1000;
    }
    
    if $abs >= 100 {
        @parts.push(%ones{$abs div 100} ~ ' hundred');
        $abs %= 100;
    }
    
    if $abs >= 20 {
        my $tens = $abs div 10 * 10;
        my $ones = $abs mod 10;
        if $ones == 0 {
            @parts.push(%tens{$tens});
        } else {
            @parts.push("%tens{$tens}-%ones{$ones}");
        }
    } elsif $abs >= 10 {
        @parts.push(%teens{$abs});
    } elsif $abs > 0 {
        @parts.push(%ones{$abs});
    }
    
    my $result = @parts.join(" ");
    return $n < 0 ?? "negative $result" !! $result;
}

sub MAIN(
    *@ints
) {
    @ints.sort({ numberToEnglish($_) }).join(q{, }).say;
}