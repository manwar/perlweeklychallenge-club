#!/usr/bin/perl

# You are given a list of @words and a string $chars.  A string is good if it
# can be formed by characters from $chars, each character can be used only
# once.  Write a script to return the sum of lengths of all good strings in
# words.

use 5.036;
use utf8;

use List::Util qw(sum0);

sub to_char_frequency ($string) {
    my %frequency_of;
    for my $char (split //, $string) {
        ++$frequency_of{$char};
    }
    return \%frequency_of;
}

sub is_subset ($subset, $superset) {
    while (my ($char, $count) = each %{$subset}) {
        return 0 if $count > ($superset->{$char} // 0);
    }
    return 1;
}

sub good_strings ($chars, @words) {
    my $valid_chars = to_char_frequency($chars);
    return grep { is_subset(to_char_frequency($_), $valid_chars) } @words;
}

sub sum_of_lengths (@words) {
    return sum0 map {length} @words;
}

say sum_of_lengths(good_strings('atach',          qw(cat bt hat tree)));
say sum_of_lengths(good_strings('welldonehopper', qw(hello world challenge)));
