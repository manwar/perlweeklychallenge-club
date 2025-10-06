#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub max_score($str) {
    my $score = ('0' eq substr $str, 0, 1) + substr($str, 1) =~ tr/1//;
    my $max_score = $score;
    for my $char (split //, substr $str, 1, -1) {
        $score += $char eq '0' ? 1 : -1;
        $max_score = $score if $score > $max_score;
    }
    return $max_score
}

sub max_score_naive($str) {
    my $max = 0;
    for my $i (1 .. length($str) - 1) {
        my $score = substr($str, 0, $i) =~ tr/0// + substr($str, $i) =~ tr/1//;
        $max = $score if $score > $max;
    }
    return $max
}

use Test::More tests => 2 * 5 + 1;

for my $max_score (\&max_score, \&max_score_naive) {
    is $max_score->('0011'), 4, 'Example 1';
    is $max_score->('0000'), 3, 'Example 2';
    is $max_score->('1111'), 3, 'Example 3';
    is $max_score->('0101'), 3, 'Example 4';
    is $max_score->('011101'), 5, 'Example 5';
}

use Benchmark qw{ cmpthese };

my $str = '101010101010001110101111';
is max_score($str), max_score_naive($str), 'Same';

cmpthese(-3, {
    naive => sub { max_score_naive($str) },
    opt   => sub { max_score($str) },
});

__END__

          Rate naive   opt
naive 189740/s    --  -42%
opt   324620/s   71%    --
