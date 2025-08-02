use strict;
use warnings;
use feature 'say';

sub jumble_letters {
    my $in = shift;
    my @out;
    for my $word (split /\s+/, $in) {
        my @letters = split //, $word;
        my $punctuation = "";
        $punctuation = pop @letters if $word =~ /.*\W$/;
        my @inner_letters = @letters[1..$#letters-1];
        my @scrambled;
        while (@inner_letters) {
            my $index = int rand scalar @inner_letters;
            push @scrambled, $inner_letters[$index];
            splice @inner_letters, $index, 1;
        }
        @letters[1..$#letters-1] = @scrambled;
        my $out_word = (join "", @letters) . $punctuation;
        push @out, $out_word;
    }
    return join " ", @out;
}

my @tests = ( "Ask not what your country can do for you, ask what you can do for your country",
              "I have a dream that one day this nation will rise up and live out the true meaning of its creed.",
              "The greatest thing you will ever learn is just to love and be loved in return.");
for my $test (@tests) {
    say $test;
    say jumble_letters $test;
    say "";
}
