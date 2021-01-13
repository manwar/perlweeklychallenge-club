#!env raku
#
#
# Task 2
# <https://perlweeklychallenge.org/blog/perl-weekly-challenge-052/>
#
# Suppose there are following coins arranged on a table in a line in random order.
# £1, 50p, 1p, 10p, 5p, 20p, £2, 2p
# Suppose you are playing against the computer.
# Player can only pick one coin at a time from either ends.
# Find out the lucky winner, who has the larger amounts in total?

my @moneys = 1, 0.5, 0.01, 0.05, 0.2, 2, 0.02;


@moneys.say;
my @moves;

my ( @player, @computer );


# First approach: let's cheat and make the player choose always the max
# value there is on the table
while ( @moneys.elems ) {
    my $left  = @moneys.shift || 0;
    my $right = @moneys.pop   || 0;

    @player.push:   $left > $right ?? $left !! $right;
    @computer.push: $left > $right ?? $right !! $left;
}


say "Player wins with { @player } = { [+] @player } vs { @computer } = { [+] @computer }";


say "Let's play another random turn";

@player   = ();
@computer = ();
@moneys   = 1, 0.5, 0.01, 0.05, 0.2, 2, 0.02;

while ( @moneys.elems ) {
    if 99.rand.Int %% 2 {
        @player.push:   @moneys.shift || 0;
        @computer.push: @moneys.pop   || 0;
    }
    else {
        @player.push:   @moneys.pop   || 0;
        @computer.push: @moneys.shift || 0;

    }
}

my $player-score   = [+] @player;
my $computer-score = [+] @computer;

say "Computer wins with { @computer } = $computer-score VS { @player } = $player-score" if $computer-score > $player-score;
say "Computer looses with { @computer } = $computer-score VS { @player } = $player-score" if $computer-score < $player-score;
say "Tie!" if $computer-score == $player-score;
