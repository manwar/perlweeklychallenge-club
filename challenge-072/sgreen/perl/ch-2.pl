#!/usr/bin/perl

use strict;
use warnings;
use 5.10.1;

sub main (@) {
    my ( $file, $start, $end ) = @_;

    # Sanity check
    die "File '$file' does not exist or is not readable\n" unless -r $file;
    die "The start value must be a positive number\n"
      unless $start =~ /^[0-9]+$/;
    die "The end value must be a positive number\n" unless $end =~ /^[0-9]+$/;
    die "The start value cannot be greater than the end value\n"
      if $start > $end;

    # Open the file
    open( my $fh, '<', $file ) or die $!;

    my $cnt = 0;
    while ( my $line = <$fh> ) {
        ++$cnt;

        # We don't print lines before $start
        next if $cnt < $start;

        print $line;

        # Likewise, if we have reached $end, their is nothing more to print
        last if $cnt == $end;
    }

    close $fh;

}

main(@ARGV);
