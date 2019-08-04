#!/usr/bin/env perl

use Modern::Perl '2018';

my $line_break  = $/;
my $space_width = 1;
my $line_width  = 72;
my @text = split /\s+/, join '', <>;
my $space_left  = $line_width;

foreach my $word (@text) {
    if((length $word) + $space_width > $space_left) {
        $word = $line_break . $word;
        $space_left = $line_width - (length $word);
    }

    else {
        $space_left -= (length $word) + $space_width;
    }
}

say "@text";
