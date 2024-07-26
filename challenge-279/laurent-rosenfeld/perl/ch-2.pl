use strict;
use warnings;
use feature 'say';

sub split_string {
    my @vowels = grep {/[aeiou]/i} split "", shift;
    scalar @vowels % 2 == 0 ? "true" : "false";

}

for my $test ("Perl", "book", "bOok", "good morning") {
    printf "%-12s => ", $test;
    say split_string $test;
}
