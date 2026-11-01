#!/usr/bin/perl

use v5.26;
use warnings;
use experimental 'signatures';


### Options and Arguments

usage() unless 1 || @ARGV;

sub usage {
    die <<~EOS;
    $0 - coin game

    usage: $0 N...

    N...
        a list of numbers

    EOS
}


### Input and Output

say "Full game analysis: @{[find_best(@ARGV)]}";

say "Playing:";
play(@ARGV);

### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/30/ch-052.html#task-2

# returns minimax path and result:
# - path:
#   H, h for accessing the head
#   T, t for accessing the tail
#   upper case for player one, lower case for player two
# - result:
#   this is the guaranteed gain for player one
#
sub find_best {
    my $head = $_[0];
    my $tail = $_[-1];

    return ('t', 0) if @_ == 1;
    return $head >= $tail ? ('Ht', $head) : ('Tt', $tail) if @_ == 2;

    my ($hpath, $hsum) = __SUB__->(@_[1 .. $#_]);
    my ($tpath, $tsum) = __SUB__->(@_[0 .. $#_ - 1]);

    # player 2 (odd) minimizes, player 1 (even) maximizes
    @_ % 2 ? $hsum >= $tsum                 ? ('t' . $tpath, $tsum) :
                                              ('h' . $hpath, $hsum) :
             $hsum + $head >= $tsum + $tail ? ('H' . $hpath, $hsum + $head) :
                                              ('T' . $tpath, $tsum + $tail);
}

# Find the best next move: head -> 0, tail -> 1
sub next_step {
    my ($path) = find_best(@_);
    $path =~ /^(?:(h)|(t))/i;
    $1 ? 0 : 1;
}

# Play a simple game against a perfect machine:
# pick all even or all odd items
sub play {
    state $ht = [qw(head tail)];
    say("Cannot be player two"), return if @_ % 2;
    my $total = 0;
    my @sum;
    $sum[$_ % 2] += $_[$_] for 0 .. $#_;
    my $target = $sum[0] <= $sum[1];
    say +(qw(Even Odd))[$target], " positions chosen.";
    while (@_) {
        my $self = splice @_, -$target, 1;
        $total += $self;
        say "player one: $ht->[$target] $self";
        # against the machine:
        $target = next_step(@_);
        my $other = splice @_, -$target, 1;
        say "player two: $ht->[$target] $other";
    }
    say "total: $total";
}

