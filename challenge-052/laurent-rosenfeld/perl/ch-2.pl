use strict;
use warnings;
use feature "say";

my @coins = @ARGV > 0 ? @ARGV : (100, 50, 1, 10, 5, 20, 200, 2);

my ($index200) = grep $coins[$_] == 200, 0..$#coins;
my @before = @coins[0..$index200-1];
my @after = @coins[$index200+1..$#coins];
ask();
while (my $move = <STDIN>) {
    chomp $move;
    last if $move eq "";
    my $coin;
    if ($move eq "B") {
        $coin = shift @before // 200;
    } elsif ($move eq "E") {
        $coin = pop @after // 200;
    } else {
        say "Invalid choice"; next;
    }
    if ($coin == 200) {
        say "You win!"; last;
    }
    if (@before == 0) {
        say "I pick the 200p coin at start and win"; last;
    } elsif (@after == 0) {
        say "I pick the 200p coin at end and win"; last;
    }
    if (@before % 2 == 0) {
        $coin = shift @before;
    } elsif (@after %2 == 0) {
        $coin = pop @after;
    } else {
        # no winning move, let's hope for a mistake
        if (@before > @after) {
            $coin = shift @before;
        } else {
            $coin = pop @after;
        }
    }
    ask();
}

sub ask {
    say "New situation = @before 200 @after";
    say "Pick a coin at beginning (B) or end (E)";
}
