#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub wordWrap {
    my ($paragraph, $lineWidth) = @_;

    my $spaceLeft = $lineWidth + 1;

    while ( $paragraph =~ /\G (?<word> \w+)(\W+)? /gcx ) {
        my $wordWidth = length $+{word};
        if ($wordWidth + 1 > $spaceLeft) {
            print "\n";
            $spaceLeft = $lineWidth - $wordWidth;
        } else {
            $spaceLeft -= ($wordWidth + 1);
        }
        print "$+{word} ";
    }
}
