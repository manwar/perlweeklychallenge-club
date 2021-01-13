#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw(uniq);

sub main {
    my $file = shift;

    # Sanity check
    die "File does not exist or is not readable\n" if !-f $file && !-r $file;

    # Read the file, and slurp it into $string
    my $string = '';
    open( my $fh, '<', $file ) or die "Cannot read $!";
    while ( my $line = <$fh> ) { $string .= $line }

    # Remove ignored characters (from the task). Replace them with a
    # space incase they are a word seperator
    $string =~ s/(\.|"|\(|\)|,|'s|--)/ /mg;

    # Find the frequency of all the words
    my %frequency = ();
    foreach my $word ( split /\s+/, $string ) { $frequency{$word}++; }

    # Output the results
    for my $freq ( sort { $a <=> $b } ( uniq values %frequency ) ) {
        print $freq, ' ',
          join( ' ', sort grep { $freq == $frequency{$_} } keys %frequency ),
          "\n\n";
    }
}

main(@ARGV);
