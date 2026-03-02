#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 2
You are given an array of integers.

Write a script to return them in alphabetical order, in any language of your choosing. Default language is English.
=CHALLENGE
=head3 Example 1:
Input: (6, 7, 8, 9 ,10)
Output: (8, 9, 7, 6, 10)

eight, nine, seven, six, ten

=head3 Example 2:
Input: (-3, 0, 1000, 99)
Output: (-3, 99, 1000, 0)

minus three, ninety-nine, one thousand, zero

=head3 Example 3:
Input: (1, 2, 3, 4, 5)
Output: (5, 4, 1, 3, 2)
five, four, one, three, two

=head3 Example 4:
Input: (0, -1, -2, -3, -4)
Output: (-4, -1, -3, -2, 0)

minus four, minus one, minus three, minus two, zero

=head3 Example 5:
Input: (100, 101, 102)
Output: (100, 101, 102)

one hundred, one hundred and one, one hundred and two

=end pod

my constant BASE = <zero one two three four five six seven eight nine ten
                    eleven twelve thirteen fourteen fifteen sixteen seventeen
                    eighteen nineteen twenty>;
my constant TENS = <_ _ twenty thirty forty fifty sixty seventy eighty ninety>;
my constant HUNDRED = "hundred";
my constant THOUSAND = "thousand";
my constant MINUS = "minus";

multi num-to-text(Int:D $n where -9999 <= * <= -1 -->Str) {
    "{MINUS} {num-to-text(-$n)}";
}

multi num-to-text(Int:D $n where 0 <= * <= 20 -->Str) {
    BASE[$n];
}

multi num-to-text(Int:D $n where 21 <= * <= 99 -->Str) {
    my ($left, $sig) = $n.polymod(10);
    $left == 0 ?? TENS[$sig]
               !! "{TENS[$sig]}-{num-to-text($left)}";
}

multi num-to-text(Int:D $n where 100 <= * <= 999 -->Str) {
    my ($left, $sig) = $n.polymod(100);
    $left == 0 ?? "{num-to-text($sig)} {HUNDRED}"
               !! "{num-to-text($sig)} {HUNDRED} {num-to-text($left)}";
}

multi num-to-text(Int:D $n where 1000 <= * <= 9999 -->Str) {
    my ($left, $sig) = $n.polymod(1000);
    $left == 0 ?? "{num-to-text($sig)} {THOUSAND}"
               !! "{num-to-text($sig)} {THOUSAND} {num-to-text($left)}";
}

multi num-to-text(Int:D $n) {
    die "Input must be between -9999 and 9999, got $n";
}

sub my-sub(List $nums -->Seq) {
    $nums.sort(&num-to-text);
}

multi MAIN(Str:D $spellbound) {
    say my-sub($spellbound.split(",").map(+*).List);
}

multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    plan +@tests;
    for @tests {
        is my-sub( .<input> ), .<output>, "{.<input>}";
    }
}

sub extract-tests(-->Array[Hash]) {
    my Hash @tests;
    my $list-of-ints = rx/ \(.*\) /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($list-of-ints) .* ($list-of-ints) / {
                @tests.push(%{ input => $0.EVAL, output => $1.EVAL });
            }
        }
    }
    @tests;
}
