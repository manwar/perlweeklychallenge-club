#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub next_palindrome_number_slow {
    my ($n) = @_;
    1 until ++$n eq reverse $n;
    return $n
}

sub next_palindrome_number {
    my ($n) = @_;
    my $p = $n + 1;
    my $l = length $p;
    my $l2 = int($l / 2);
    substr $p, -$_, 1, substr $p, $_ - 1, 1 for 1 .. $l2;
    return $p if $p > $n;

    substr $p, $l2 + $l % 2, $l2, "";
    ++$p;
    $p .= '0' x $l2;
    substr $p, -$_, 1, substr $p, $_ - 1, 1 for 1 .. $l2;
    return $p
}

use Test::More;

is next_palindrome_number(1234), 1331, 'Example 1';
is next_palindrome_number(999),  1001, 'Example 2';

my @random_data = map { my $m = 10 ** $_; map int rand $m, 1 .. $_ } 1 .. 10;

for my $r (@random_data) {
    is  next_palindrome_number($r),
        next_palindrome_number_slow($r),
        "after $r";
}

done_testing();

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    slow => sub { next_palindrome_number_slow($_) for @random_data },
    fast => sub { next_palindrome_number($_)      for @random_data },
});

__END__
       Rate   slow   fast
slow 13.1/s     --  -100%
fast 9768/s 74709%     --
