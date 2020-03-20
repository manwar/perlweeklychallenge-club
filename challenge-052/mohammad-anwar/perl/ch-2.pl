#!/usr/bin/perl

use strict;
use warnings;

my $coins = {
    100 => "£1", 50 => "50p",   1 => "1p", 10 => "10p",
      5 => "5p", 20 => "20p", 200 => "£2",  2 => "2p" ,
};

my $table   = [ keys %$coins ];
my $players = {
    0 => { "name" => "Human",   "bank" => 0, "coins" => [] },
    1 => { "name" => "Machine", "bank" => 0, "coins" => [] },
};

# Pick random player 0 or 1.
# DISCLAIMER:
# E. Choroba found out the player who picks the coin
# first is always the winner.
my $current = int rand(2);

my $coin;
while ($#$table) {
    if ($table->[0] > $table->[-1]) {
        $coin = shift @$table;
    }
    else {
        $coin = pop @$table;
    }

    $players->{$current}->{bank} += $coin;
    push @{$players->{$current}->{coins}}, $coins->{$coin};

    $current = ($current)?(0):(1);
}

$coin = shift @$table;
$players->{$current}->{bank} += $coin;
push @{$players->{$current}->{coins}}, $coins->{$coin};

_declare_lucky_winner($players);
_show_coins($players);

#
#
# METHODS

sub _declare_lucky_winner {
    my ($players) = @_;

    print "The lucky winner is ";
    if ($players->{0}->{bank} > $players->{1}->{bank}) {
        print $players->{0}->{name};
    }
    else {
        print $players->{1}->{name};
    }
    print ".\n";
}

sub _show_coins {
    my ($players) = @_;

    foreach (0..1) {
        print sprintf("%s picked coins %s.\n",
            $players->{$_}->{name}, join(", ", @{$players->{$_}->{coins}}) );
    }
}
