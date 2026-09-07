#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub rational_numbers($rat1, $rat2) {
    my @rats;
    for my $r ($rat1, $rat2) {
        $r .= '.' if -1 == index $r, '.';
        $r =~ /([-+]?[0-9]+)\.([0-9]*)(?:\(([0-9]+)\))?$/;
        my ($int, $prefix, $repeated) = @{^CAPTURE};
        $repeated //= "";
        $repeated = $1 if $repeated =~ /^(.+?)\1+$/;
        while (length $repeated
               && substr($repeated, -1, 1) eq substr $prefix, -1, 1
        ) {
            substr $repeated, 0, 0, substr $prefix, -1, 1, "";
            substr $repeated, -1, 1, "";

            if ('9' eq $repeated) {
                $repeated = "";
                if (length $prefix) {
                    if ($prefix =~ /9$/) {
                        $prefix =~ s/9+$//;
                        if (length $prefix) {
                            ++$prefix;
                        } else {
                            ++$int;
                        }
                    } else {
                        ++$prefix;
                    }
                } else {
                    ++$int;
                }
                last
            }

        }
        $repeated = "" if '0' eq $repeated;
        $prefix = "" if "" eq $repeated && '0' eq $prefix;
        push @rats, "$int|$prefix|$repeated";
    }
    return $rats[0] eq $rats[1]
}

use Test2::V0;
use if ($] >= 5.036), builtin => qw( true false );
use if ($] <  5.036), constant => {true => 1, false => 0};

plan(5 + 5);

is rational_numbers('0.(12)', '0.(121)'), bool(false), 'Example 1';
is rational_numbers('0.1(23)', '0.12(32)'), bool(true), 'Example 2';
is rational_numbers('0.1(234)', '0.12(342)'), bool(true), 'Example 3';
is rational_numbers('12.99(99)', '13.'), bool(true), 'Example 4';
is rational_numbers('0.(123)', '0.1(231)'), bool(true), 'Example 5';

is rational_numbers('12.1999(99999)', '12.2'), bool(true), '(9) after prefix';
is rational_numbers('3', '3.'), bool(true), 'no dot';
is rational_numbers('3.', '3.0'), bool(true), 'decimal 0';
is rational_numbers('3.0', '3.0(0)'), bool(true), 'repeated 0';
is rational_numbers('3.12(3456)', '3.1234(563456345634)'), bool(true),
    'Longer repeated prefix part';
