#!/usr/bin/env perl

#########################
# Challenge 032, part 1 #
#########################

use strict;
use warnings;
use v5.10;

my $encoding = ':encoding(UTF-8)';

binmode STDIN, $encoding;
binmode STDOUT, $encoding;

my %words;
my $space_pos = 15;

# Reading and counting all words from
# all files
while (my $file_name = shift) {
    open (my $file_handle, "< $encoding", $file_name)
        or die "Can't open file $file_name: $!";
    while (<$file_handle>) {
        chomp;
        $words{$_}++ if defined $words{$_};
        $words{$_} = 1 unless defined $words{$_};
    }
    close $file_handle;
}

# Sorting all words by the number of
# occurrences
for my $word (sort { $words{$b} <=> $words{$a} } keys %words) {
    my $spaces = count_spaces($word);
    say $word.$spaces.$words{$word};
}

# Subfunction for calculating the number
# of spaces to position $space_pos
sub count_spaces {
    my $word = shift;
    my $n_spaces = $space_pos - length $word;
    my $spaces = ' ';
    for (1 .. $n_spaces) {$spaces = $spaces . ' '}
    return $spaces;
}
