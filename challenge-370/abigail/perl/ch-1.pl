#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    #
    # Parse input; put the banned words into %banned.
    #
    my ($paragraph, $banned) = split m!\s*//\s*!;
    my  %banned = map {$_ => 1} lc ($banned) =~ /\pL+/g;

    #
    # Initialize the hash counting unbanned words
    #
    my  %ok = ((my $max = "") => 0);

    #
    # Lowercase the paragraph, extract words (sequences of letters),
    # toss out the banned ones, and count the unbanned ones.
    #
    $ok {$_} ++ for grep {!$banned {$_}} lc ($paragraph) =~ /\pL+/g;

    #
    # Find the most frequent used word
    #
    $ok {$_} > $ok {$max} && ($max = $_) for (keys %ok);
    say $max;
}

__END__
