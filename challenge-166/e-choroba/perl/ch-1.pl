#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Syntax::Construct qw( /r );

my $goal = shift;
die "Use perldoc $0 to get the usage.\n" if $goal !~ /^[123]$/;

=head1 Arguments

ch-1.pl Goal /path/to/dictionary

where Goal is:

=over 4

=item 1

Show all the possible words.

=item 2

Limit the number of special substitutions.

=item 3

Find 8 letter phrases.

=back

=cut

my @hexadecimal_words;
my %by_length;
while (<>) {
    chomp;
    next unless /^[a-folist]+$/i;
    next if 2 == $goal && /^[olist]+$/i;
    my $word = ucfirst(lc =~ tr/olist/01157/r);
    if ($goal != 3) {
        push @hexadecimal_words, $word;
    } elsif (8 >= length $word) {
        push @{ $by_length{ length $word } }, $word;
    }
}

if ($goal != 3) {
    say for @hexadecimal_words;
} else {
    for my $l (3 .. 5) {
        for my $first (@{ $by_length{$l} }) {
            for my $rest (@{ $by_length{ 8 - $l } }) {
                say "$first$rest" unless $first eq $rest;
            }
        }
    }
}
