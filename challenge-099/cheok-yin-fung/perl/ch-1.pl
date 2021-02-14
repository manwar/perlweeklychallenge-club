#!/usr/bin/perl
# The Weekly Challenge #099
# Task 1 Pattern Match
use strict;
use warnings;

sub check {
    my $str = $_[0];
    my $t_pattern = $_[1];

    $t_pattern =~ s/\*/\\S\+/g;
    $t_pattern =~ s/\?/\./g;

    return (($str =~ /^$t_pattern$/ )? 1 : 0);
}

print check($ARGV[0], $ARGV[1]), "\n";
