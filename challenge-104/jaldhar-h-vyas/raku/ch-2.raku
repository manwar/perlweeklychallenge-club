#!/usr/bin/raku

sub plural(Str $word, Int $count) {
    return $word ~ ($count == 1 ?? q{} !! 's');
}

sub MAIN () {
    my $tokens = 12;

    while ($tokens) {
        say "There are $tokens ", plural("token", $tokens), ".";
        my $playerChoice = 0;

        loop {
            my $answer = prompt("How many tokens will you pick [1, 2 or 3]?");
            if $answer ~~ /^ \s* (1|2|3) \s* $/ {
                $playerChoice = $0;
                last;
            }
        }

        $tokens -= $playerChoice;
        if $tokens < 1 {
            say "You win!";
            last;
        }

        my $computerChoice = 4 - $playerChoice;
        say "The computer picks $computerChoice ",
            plural("token", $computerChoice);
        $tokens -= $computerChoice;

        if ($tokens < 1) {
            say "The computer wins.";
            last;
        }
    }
}