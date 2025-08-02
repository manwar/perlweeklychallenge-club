use strict;
use warnings;
use feature 'say';

sub shuffle_word {
    my ($word, $char) = @_;
    my $ind = index $word, $char;
    return $word unless $ind;
    my @prefix_letters = (split //, $word)[0..$ind];
    my $prefix = join "", sort @prefix_letters;
    return $prefix . substr $word, $ind + 1;
}

my @tests = ( [ qw<challenge e> ],
              [ qw<programming a> ],
              [ qw<champion b> ] );
for my $test (@tests) {
    printf "%-12s %-2s => ", @$test;
    say shuffle_word @$test;
}
