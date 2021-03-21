#!/usr/bin/env raku

# Formats a message defined as plural to be singular if $n == 1
sub format(Str $message, Int $n) returns Str {
    $n == 1 ?? $message.trans(['are', 'tokens'] => ['is', 'token']) !! $message;
}

sub challenge(Int $n) {
    my $remaining = $n;

    # Defined within the challenge sub because it references $remaining
    sub default-prompt returns Any {
        prompt(format("There are $remaining tokens. How many would you like to pick up? (1, 2, 3) ", $remaining));
    }

    my $input = default-prompt;
    my $most-recent-move;
    while $remaining > 0 {
        given $input {
            when 1|2|3 {
                if $input > $remaining {
                    $input = prompt("There are only $remaining tokens left. Please enter a valid number ")
                } else {
                    say format("You take $input tokens", $input);
                    $remaining -= $input;
                    $most-recent-move = 'You';

                    last if $remaining == 0;

                    # If there are only 3 or less tokens, take all of them. Otherwise, take a random number between 1 and 3
                    my $bot-move = $remaining ~~ 1|2|3 ?? $remaining !! (1..3).pick;
                    say format("The computer takes $bot-move tokens", $bot-move);
                    $remaining -= $bot-move;
                    $most-recent-move = 'Computer';

                    last if $remaining == 0;

                    $input = default-prompt;
                }
            }
            default { $input = prompt('Please enter 1, 2, or 3 ') }
        }
    }
    say $most-recent-move eq 'Computer' ?? 'The computer wins!' !! 'You win!';
}

sub MAIN(Int $n where $n > 0 = 12) {
    challenge($n);
}
