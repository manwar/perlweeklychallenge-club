#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say signatures);
no warnings qw(experimental::signatures);

use Data::Section::Simple qw(get_data_section);

MAIN: {
    say sprintf "Line length: %s\n%s\n", $_, wrap(get_data_section('sample'), $_)
        foreach map { 20 * $_ } 1..3;
}

sub wrap ($text, $line_width = 60) {
    my $sep = ' ';
    my $space_left = $line_width;
    my $space_width = length $sep;
    my $wtext = '';

    foreach my $word (split $sep, $text) {
        my $word_len = length $word;
        if ($word_len + $space_width > $space_left) {
            $wtext .= "\n$word$sep";
            $space_left = $line_width - $word_len;
        } else {
            $space_left = $space_left - ($word_len + $space_width);
            $wtext .= "$word$sep";
        }
    }
    return $wtext;
}

1;

__DATA__

@@ sample
A simple way to do word wrapping is to use a greedy algorithm that puts as many
words on a line as possible, then moving on to the next line to do the same

__END__

$ perl ch-2.pl
Line length: 20
A simple way to do
word wrapping is to
use a greedy
algorithm that puts
as many words on a
line as possible,
then moving on to
the next line to do
the same

Line length: 40
A simple way to do word wrapping is to
use a greedy algorithm that puts as many
words on a line as possible, then moving
on to the next line to do the same

Line length: 60
A simple way to do word wrapping is to use a greedy
algorithm that puts as many words on a line as possible,
then moving on to the next line to do the same
