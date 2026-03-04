#!/usr/bin/env perl

use Modern::Perl;

sub is_palindrome {
    my($n) = @_;
    return "$n" eq join("", reverse split //, "$n");
}

sub next_palindrome {
    my($n) = @_;
    my $out;
    for (my $i = 1; !defined($out) || $i <= $n; $i++) {
        my $t = $n-$i;
        if ($t >= 0 && is_palindrome($t)) {
            if (!defined($out) || abs($out-$n) > abs($t-$n)) {
                $out = $t;
            }
        }

        $t = $n+$i;
        if (is_palindrome($t)) {
            if (!defined($out) || abs($out-$n) > abs($t-$n)) {
                $out = $t;
            }
        }
    }
    return $out;
}

my $n = shift // 0;
say next_palindrome($n);
