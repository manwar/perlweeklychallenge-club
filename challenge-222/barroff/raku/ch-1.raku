#!/usr/bin/env raku

use v6.d;

multi sub last-member(*@numbers where @numbers.elems == 0 --> Int) {
    0;
}

multi sub last-member(*@numbers where {@numbers.elems == 1 and @numbers[0] ~~ Int:D} --> Int) {
    @numbers[0];
}

multi sub last-member(*@numbers where {@numbers.elems > 1 and $_.all ~~ Int:D}  --> Int) {
    # my @sorted-numbers = reverse(sort(@numbers));
    my @sorted-numbers = sort({ $^a < $^b }, @numbers);
    @sorted-numbers[0] == @sorted-numbers[1]
        ?? last-member(@sorted-numbers[2..*-1])
        !! last-member(@sorted-numbers[2..*-1],
            @sorted-numbers[0] - @sorted-numbers[1]);
}

sub last-member2(*@numbers where {$_.all ~~ Int:D}  --> Int) {
    given @numbers.elems {
        when 0 { return 0 }
        when 1 { return @numbers[0] }
        default { 
            my @sorted-numbers = sort( { $^a < $^b }, @numbers);
            @sorted-numbers[0] == @sorted-numbers[1]
                ?? last-member2(@sorted-numbers[2..*-1])
                !! last-member2(@sorted-numbers[2..*-1],
                    @sorted-numbers[0] - @sorted-numbers[1]);
        }
    }
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 6;

    is last-member(2, 7, 4, 1, 8, 1), 1, 'works for (2, 7, 4, 1, 8, 1)';
    is last-member(1), 1, 'works for (1)';
    is last-member(1, 1), 0, 'works for (1, 1)';

    is last-member2(2, 7, 4, 1, 8, 1), 1, 'works for (2, 7, 4, 1, 8, 1)';
    is last-member2(1), 1, 'works for (1)';
    is last-member2(1, 1), 0, 'works for (1, 1)';
}

#| Take user provided list like 1 17 8
multi sub MAIN(*@numbers where @numbers.elems ≥ 1) {
    say last-member(@numbers);
}
