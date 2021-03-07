#!/usr/bin/perl
use warnings;
use strict;

# As Palindromic Rare Numbers were mentioned separately, I only
# considered non-palindromic ones.

# Originally, I checked all the numbers, but the tests took more than
# 4 minutes. So I decided to generate the numbers instead (even if the
# middle part is still checking all the possibilities). The tests now
# take 37 seconds on my machine. You can find the original code after
# the END marker.

sub is_rare {
    my ($n, $r) = @_;
    return if $n <= $r;

    my $diff = $n - $r;
    my $sqrt_diff = sqrt $diff;
    return unless int($sqrt_diff) * int($sqrt_diff) == $diff;

    my $sum = $n + $r;
    my $sqrt_sum = sqrt $sum;
    return unless int($sqrt_sum) * int($sqrt_sum) == $sum;

    return 1
}

sub inner_iterator {
    my ($size) = @_;
    if (4 == $size) {
        my $first = 1;
        return sub {
            undef $first, return ""
                if $first;

            return
        }
    } else {
        my $max = 9 x ($size - 4);
        my $n = 0;
        return sub {
            return sprintf '%0*d', $size - 4, $n - 1
                if $n++ <= $max;

            return
        }
    }
}

my %start_end = (
    2 => {2 => [map [$_, $_], 0 .. 9]},
    4 => {0 => [map {
                    my $x = $_;
                    map [$x, $_], grep 0 == abs($x - $_) % 2, 0 .. 9
                } 0 .. 9 ]},
    6 => {map {$_ => [map {
                          my $x = $_;
                          map [$x, $_], grep 1 == abs($x - $_) % 2, 0 .. 9
                      } 0 .. 9]} 0, 5},
    8 => {2 => [map [$_, 9 - $_], 0 .. 9],
          3 => [map [$_, $_ + ($_ < 7 ? 3 : -7)], 0 .. 9],
          7 => [map [$_, ($_ > 1 ? 11 : 1) - $_], 0 .. 9],
          8 => [map [$_, $_], 0 .. 9]}
);

sub rare_numbers {
    my ($size) = @_;
    return [] if $size < 2;  # Single digit numbers are palindromes.

    my @rare;
    if ($size < 4) {
        for (my $n = 10 ** ($size - 1); $n < 10 ** $size; ++$n) {
            if ($n =~ /^([^2468])/) {
                $n = $1 . '9' x ($size - 1);
                next
            }
            push @rare, $n if is_rare($n, scalar reverse $n);
        }

    } else {
        for my $start (keys %start_end) {
            for my $end (keys %{ $start_end{$start} }) {
                for my $pair (@{ $start_end{$start}{$end} }) {
                    my $inner_iterator = inner_iterator($size);
                    while (defined(my $inner = $inner_iterator->())) {
                        my $n = join "", $start, $pair->[0],
                                         $inner, $pair->[1], $end;
                        push @rare, $n if is_rare($n, scalar reverse $n);
                    }
                }
            }
        }
    }
    return \@rare
}

use Test::More;

is_deeply rare_numbers(2), [65], '(a)';
is_deeply rare_numbers(6), [621770], '(b)';
is_deeply rare_numbers(9), [281089082], '(c)';
is_deeply rare_numbers($_), [], "empty $_" for 1, 3, 4, 5, 7, 8;

done_testing();

__END__

sub rare_numbers {
    my ($size) = @_;
    my $from = 10 ** ($size - 1);
    my $to = '9' x $size;
    my @rare;
    for (my $n = $from; $n <= $to; ++$n) {
        if ($n =~ /^([^2468])/) {
            $n = $1 . '9' x ($size - 1);
            next
        }

        my $r = reverse $n;
        next if $n <= $r;

        my $diff = $n - $r;

        my $sqrt_diff = sqrt $diff;
        next unless $sqrt_diff == int $sqrt_diff;

        my $sum = $n + $r;
        my $sqrt_sum = sqrt $sum;
        next unless $sqrt_sum == int $sqrt_sum;

        push @rare, $n;
    }
    return \@rare
}
