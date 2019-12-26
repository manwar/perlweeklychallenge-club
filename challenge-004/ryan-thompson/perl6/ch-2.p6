#!/usr/bin/env perl6

# ch-2.p6 - Print words that only contain letters in argument
#
# Ryan Thompson <rjt@cpan.org>

sub MAIN( Str $letter-string ) {
    my $letters = $letter-string.fc.comb.Bag;

    .say for $*ARGFILES.lines.grep: { .fc.comb.Bag ⊆ $letters }

}
