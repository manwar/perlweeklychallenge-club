#!/usr/bin/perl
use 5.020;
use warnings;

sub plural {
    my ($word, $count) = @_;
    return $word . ($count == 1 ? q{} : 's');
}

my $tokens = 12;

while ($tokens) {
    say "There are $tokens ", plural("token", $tokens), ".";
    my $playerChoice = 0;

    while (1) {
        print "How many tokens will you pick [1, 2 or 3]?";
        my $answer = <>;
        if ($answer =~ /\A \s* (1|2|3) \s* \z/msx) {
            $playerChoice = $1;
            last;
        }
    }

    $tokens -= $playerChoice;
    if ($tokens < 1) {
        say "You win!";
        last;
    }

    my $computerChoice = 4 - $playerChoice;
    say "The computer picks $computerChoice ", plural("token", $computerChoice);
    $tokens -= $computerChoice;

    if ($tokens < 1) {
        say "The computer wins.";
        last;
    }
}
