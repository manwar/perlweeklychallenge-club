#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    # Replace literal `\n` with a new line
    $input_string =~ s/\\n/\n/g;

    # Split the words and HTML tags from the other parts of the string
    my $regexp = qr/(<[^>]+>|[a-z0-9]+(?:['-][a-z0-9]+)*)/i;
    my @parts  = split $regexp, $input_string;

    # Find the position of all the words (exclude non words and HTML tags)
    my @word_positions =
      grep { $_ % 2 == 1 and $parts[$_] !~ /^<.+>$/ } ( 0 .. $#parts );

    # Find any double words and alter as needed
    foreach my $pos ( 0 .. $#word_positions - 1 ) {
        my $this_pos = $word_positions[$pos];
        my $next_pos = $word_positions[ $pos + 1 ];
        if ( lc( $parts[$this_pos] ) eq lc( $parts[$next_pos] ) ) {
            $parts[$this_pos] = "[" . $parts[$this_pos] . "]";
            $parts[$next_pos] = "[" . $parts[$next_pos] . "]";
        }
    }

    # Split into lines
    my @input_lines  = split /[\r\n]+/, $input_string;
    my @output_lines = split /[\r\n]+/, join( "", @parts );

    # Find the lines that are different from the original
    my @different_lines = map { $output_lines[$_] }
      grep { $input_lines[$_] ne $output_lines[$_] } ( 0 .. $#output_lines );

    # Display the different lines with a literal `\n` for new line characters
    say '"'.join( '\n', @different_lines ).'"';
}

main(@ARGV);
