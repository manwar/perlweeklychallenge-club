#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 1
You are given a positive integer (<= 100).

Write a script to return Zeckendorf Representation of the given integer.

Every positive integer can be uniquely represented as sum of non-consecutive Fibonacci numbers.
=CHALLENGE
=head3 Example 1:
Input: $int = 4
Output: 3,1

4 => 3 + 1 (non-consecutive fibonacci numbers)

=head3 Example 2:
Input: $int = 12
Output: 8,3,1

12 => 8 + 3 + 1

=head3 Example 3:
Input: $int = 20
Output: 13,5,2

20 => 13 + 5 + 2

=head3 Example 4:
Input: $int = 96
Output: 89,5,2

96 => 89 + 5 + 2

=head3 Example 5:
Input: $int = 100
Output: 89,8,3

100 => 89 + 8 + 3

=end pod

my @fib = (1, 2, * + * ...^ * > 100).reverse;

multi my-sub(Int:D $int -->Str:D) {
    my @result;
    for @fib -> $candidate {
        state $sum = 0;
        if $candidate + $sum <= $int {
            @result.push($candidate);
            $sum += $candidate
        }
        say @result, " ", $sum, " ", $candidate if $*verbose;
    }
    @result.join(",");
} 

multi MAIN(Int:D $int where {$int > 0 && $int <= 100}, Bool:D :$verbose = True) {
    my $*verbose = $verbose;
    say my-sub($int);
}

multi MAIN(Int:D $int, Bool:D :$verbose = True) {
    die "Input must be between 1 and 100, got $int.";
}

multi MAIN(Bool:D :$test, Bool:D :$verbose = False) {
    use Test;

    my $*verbose = $verbose;
    my @tests = extract-tests;
    plan +@tests;
    for @tests {
        is my-sub( .<input> ), .<output>, "{.<input>}";
    } 
}

sub extract-tests(-->Array[Hash]) {
    my Hash @tests;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / \: \D+ (\d+) \D+? (<[0..9\,]>+) / {
                @tests.push(%{ input => +$0, output => ~$1 });
            }
        }
    }
    @tests;
}

