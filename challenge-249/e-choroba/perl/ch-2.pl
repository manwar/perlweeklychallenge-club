#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Test2::V0;
use experimental qw( signatures );

sub DI_string_match($str) {
    my @p = (0);
    my $max = 1;
    my %DISPATCH = (I => sub {
                        push @p, $max++;
                    },
                    D => sub {
                        $_++ for @p, $max;
                        push @p, 0;
                    });
    $DISPATCH{$_}() for split //, $str;
    return \@p
}

{   my %DISPATCH = (D => sub($perm, $i) { $perm->[$i - 1] > $perm->[$i] },
                    I => sub($perm, $i) { $perm->[$i - 1] < $perm->[$i] });
    sub matches($s, $perm) {
        return unless @$perm - 1 == length $s;
        my %used;
        @used{@$perm} = ();
        exists $used{$_} or return for 0 .. length $s;

        for my $i (1 .. length $s) {
            my $char = substr $s, $i - 1, 1;
            return unless $DISPATCH{$char}($perm, $i);
        }
        return 1
    }
}

plan 3 + 5 + 3;

is matches('IDID', [0, 4, 1, 3, 2]), 1, 'matches() correct for Example 1';
is matches('III', [0, 1, 2, 3]), 1, 'matches() correct for Example 2';
is matches('DDI', [3, 2, 0, 1]), 1, 'matches() correct for Example 3';

is matches('I', [1, 0]), undef, 'matches() detects wrong order';
is matches('D', [0, 1]), undef, 'matches() detects wrong order';
is matches('I', [0, 2]), undef, 'matches() checks the range';
is matches('III', [0, 1, 2]), undef, 'matches() rejects shorter';
is matches('III', [0, 1, 2, 3, 4]), undef, 'matches() rejects longer';

is matches('IDID', DI_string_match('IDID')), 1, 'Example 1';
is matches('III', DI_string_match('III')), 1, 'Example 2';
is matches('DDI', DI_string_match('DDI')), 1, 'Example 3';
