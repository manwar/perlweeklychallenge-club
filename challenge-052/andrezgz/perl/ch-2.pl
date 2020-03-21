#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-052/
# Task #2
#
# Lucky Winner
# Suppose there are following coins arranged on a table in a line
# in random order.
#
# £1, 50p, 1p, 10p, 5p, 20p, £2, 2p
#
# Suppose you are playing against the computer.
# Player can only pick one coin at a time from either ends.
# Find out the lucky winner, who has the larger amounts in total?

use strict;
use warnings;
use v5.10;

my %coin_value = (
    1   => '1p',
    2   => '2p',
    5   => '5p',
    10  => '10p',
    20  => '20p',
    50  => '50p',
    100 => '£1',
    200 => '£2',
);

# Schwartzian transform to randomize order
# although some randomness could be obtained by a simple: keys %coin_value
my @coins = map  { $_->[0] }
            sort { $a->[1] <=> $b->[1] }
            map  { [$_, int rand 8] }
            keys %coin_value;

my (@user, @computer);

while (@coins) {

    # USER
    list_coins('Coins on the table',@coins);
    say "> Please choose L (for $coin_value{$coins[0]}), R (for $coin_value{$coins[-1]}) or Q to quit";

    my $letter = uc <STDIN>;
    chomp $letter;
    redo unless $letter =~ /^[RLQ]$/;
    exit 0 if $letter eq 'Q';

    my $chosen = $letter eq 'L' ? shift @coins : pop @coins;
    push @user, $chosen;

    # COMPUTER
    list_coins('Coins on the table',@coins);

    $chosen = $coins[0] > $coins[-1] ? shift @coins : pop @coins;
    push @computer, $chosen;
    say "Computer chooses: $coin_value{$chosen}";

}

say $/ . 'Final Result' . $/ . '-' x 12;
list_coins('User',@user);
list_coins('Computer',@computer);

my ($u,$c) = (0,0);
$u += $_ for (@user);
$c += $_ for (@computer);
say $/, $u > $c ? 'User' : 'Computer', ' is the lucky winner!';

sub list_coins {
    my ($name,@coins) = @_;
    say $/ . $name. ': ' . join ',', map {$coin_value{$_}} @coins;
}
