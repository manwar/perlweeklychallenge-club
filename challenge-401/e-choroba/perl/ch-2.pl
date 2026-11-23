#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my @digits = qw( zero one two three four five six seven eight nine );
my %word2num;
@word2num{ @digits } = 0 .. 9;

my %in_word;
for my $digit (@digits) {
    for my $char (split //, $digit) {
        ++$in_word{$char}{$digit};
    }
}

my %repeated;
undef @repeated{grep { grep 1 != $_, values %{ $in_word{$_} } } keys %in_word};
delete @in_word{ keys %repeated };

my @identifies;
for (my $i = 0; keys %in_word; ++$i) {
    for my $char (keys %in_word) {
        my @words = keys %{ $in_word{$char} };
        $identifies[$i]{$char} = $words[0] if 1 == @words;
    }
    delete @in_word{ keys %{ $identifies[$i] } };
    for my $done (values %{ $identifies[$i] }) {
        for my $ch (keys %in_word) {
            delete $in_word{$ch}{$done};
            delete $in_word{$ch} unless keys %{ $in_word{$ch} };
        }
    }
}

sub reconstruct_digits($str) {
    my %freq;
    for my $i (0 .. $#identifies) {
        for my $char (keys %{ $identifies[$i] }) {
            my $count = eval "\$str =~ tr/$char//";
            next unless $count;

            for my $char_in_digit (split //, $identifies[$i]{$char}) {
                $str =~ s/$char_in_digit//
                    or die "$identifies[$i]{$char} expected but not complete: "
                           . "$char_in_digit missing"
                           for 1 .. $count;
            }
            $freq{ $word2num{ $identifies[$i]{$char} } } += $count;
        }
    }

    my $n;
    for my $d (sort keys %freq) {
        $n .= $d x $freq{$d};
    }
    return $n
}

use Test::More tests => 5 + 10;

is reconstruct_digits('zroezerotwotwotwo'), '00222', 'Example 1';
is reconstruct_digits('sveeeinght'), '78', 'Example 2';
is reconstruct_digits('onenineninefive'), '1599', 'Example 3';
is reconstruct_digits('zeroonetwothreeeightfivesixsevenninefour'),
    '0123456789',
    'Example 4';
is reconstruct_digits('ninenineninenine'), '9999', 'Example 5';

use List::Util qw{ shuffle };

for (1 .. 10) {
    my @numbers = map +(int rand 10) x (1 + rand 5), 1 .. 1 + rand 20;
    my @chars = shuffle(map { split // } @digits[@numbers]);
    my $n = reconstruct_digits(join "", @chars);
    is $n, join("", sort @numbers), "Same $n";
}
