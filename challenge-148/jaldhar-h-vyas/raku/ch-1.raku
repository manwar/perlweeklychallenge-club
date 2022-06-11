#!/usr/bin/raku

sub MAIN() {
    my %spelling = (
        1 => 'one',
        2 => 'two',
        3 => 'three',
        4 => 'four',
        5 => 'five',
        6 => 'six',
        7 => 'seven',
        8 => 'eight',
        9 => 'nine',
        10 => 'ten',
        11 => 'eleven',
        12 => 'twelve',
        13 => 'thirteen',
        14 => 'fourteen',
        15 => 'fifteen',
        16 => 'sixteen',
        17 => 'seventeen',
        18 => 'eighteen',
        19 => 'nineteen',
        100 => 'hundred'
    );

    my @tens =
        Nil,
        Nil,
        'twenty',
        'thirty',
        'forty',
        'fifty',
        'sixty',
        'seventy',
        'eighty',
        'ninety',
    ;

    for 20 .. 99 -> $n {
        my ($ten, $unit) = $n.comb;
        %spelling{$n} = @tens[$ten] ~ ($unit == 0 ?? q{} !! "-%spelling{$unit}");
    }

    %spelling.keys
        .grep({ !%spelling{$_}.match(/e/); })
        .sort({ $^a <=> $^b })
        .join(q{, })
        .say;
}
