#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Challenge 368 Task 2 Big and Little Omega
Submitted by: Roger Bell_West
=CHALLENGE
You are given a positive integer $number and a mode flag $mode. If the mode flag is zero, calculate little omega (the count of all distinct prime factors of that number). If it is one, calculate big omega (the count of all prime factors including duplicates).
=head3 Example 1:
Input: $number = 100061
       $mode = 0
Output: 3

Prime factors are 13, 43, 179. Count is 3.
=head3 Example 2:
Input: $number = 971088
       $mode = 0
Output: 3

Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.
=head3 Example 3:
Input: $number = 63640
       $mode = 1
Output: 6

Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.
=head3 Example 4:
Input: $number = 988841
       $mode = 1
Output: 2
=head3 Example 5:
Input: $number = 211529
       $mode = 0
Output: 2
=end pod

subset PositiveInt of Int where * > 0;
enum Omega <Little Big>;

sub prime-factors(PositiveInt $number -->Array[Int]) {
    my @result of Int;
    my $n = $number;
    my $i = 2;
    while $i * $i <= $n {
        while $n %% $i {
            $n div= $i;
            @result.push($i);
        }
        $i++;
    }
    @result.push($n) if $n != 1;
    @result;
}

multi my-sub(PositiveInt $number, Omega(Int) $mode -->Int) {
    my @factors = prime-factors($number);
    $mode == Little ?? @factors.unique.elems !! @factors.elems;
}

multi my-sub(Int:D $number, Int:D $mode -->Int) {
    die "unexpected input, received $number, $mode";
}

multi MAIN(Int:D $number, Int:D $mode) {
    say my-sub($number, $mode);
}

multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    @tests.push(%{ input => (4, 1), output => 2 });
    @tests.push(%{ input => (12, 0), output => 2 });
    @tests.push(%{ input => (12, 1), output => 3 });
    @tests.push(%{ input => (1, 0), output => 0 });
    @tests.push(%{ input => (1, 1), output => 0 });

    my @should-throw;
    @should-throw.push(%{ input => (1, 2) });
    @should-throw.push(%{ input => (0, 0) });
    @should-throw.push(%{ input => (-5, -5) });
    
    plan @tests + @should-throw;
    for @tests {
        is my-sub(|.<input>), .<output>, "{.<input>}";
    }
    for @should-throw {
        dies-ok { my-sub(|.<input>) }, "dies on {.<input>}";
    }
}

sub extract-tests(-->Array[Hash]) {
    my Hash @tests;
    my $int = / << \d+ >> /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / number .* ($int) .* ($int) .* ($int)  / {
                @tests.push(%{ input => (+$0, +$1), output => +$2 });
            }
        }
    }
    @tests;
}
