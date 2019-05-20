#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub center {
    my @lines;
    my @results;

    for my $line (@_) {
        push @lines, { length => length $line, text => $line };
    }

    my $maxLength = (sort { $a->{length} < $b->{length}} @lines)[0]->{length};

    for my $line (@lines) {
        push @results,
            q{ } x (($maxLength - $line->{length}) / 2) . "$line->{text}\n";
    }

    return @results;
}

print center(@ARGV);
