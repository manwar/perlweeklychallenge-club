#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

sub invalidate($final) { pop @$final }
sub double($final)     { push @$final, 2 * $final->[-1] }
sub add($final)        { push @$final, $final->[-1] + $final->[-2] }

my %DISPATCH = (
    C => \&invalidate,
    D => \&double,
    '+' => \&add,
);

sub final_score(@scores) {
    my @final;
    for my $score (@scores) {
        if (exists $DISPATCH{$score}) {
            $DISPATCH{$score}->(\@final);
        } else {
            push @final, $score;
        }
    }
    return sum(@final)
}

use Test::More tests => 5;

is final_score('5', '2', 'C', 'D', '+'), 30, 'Example 1';
is final_score('5', '-2', '4', 'C', 'D', '9', '+', '+'), 27, 'Example 2';
is final_score('7', 'D', 'D', 'C', '+', '3'), 45, 'Example 3';
is final_score('-5', '-10', '+', 'D', 'C', '+'), -55, 'Example 4';
is final_score('3', '6', '+', 'D', 'C', '8', '+', 'D', '-2', 'C', '+'), 128,
    'Example 5';
