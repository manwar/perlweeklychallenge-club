#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-10-09
# Week: 029

# Task #1
# Write a script to demonstrate brace expansion. For example, script
# would take command line argument Perl {Daily,Weekly,Monthly,Yearly}
# Challenge and should expand it and print like below:
#
#   Perl Daily Challenge
#   Perl Weekly Challenge
#   Perl Monthly Challenge
#   Perl Yearly Challenge

use strict;
use warnings;
use feature qw/ say /;

my $cmd_line_arg = "Perl {Daily,Weekly,Monthly,Yearly} Challenge";
say "The command line argument \"$cmd_line_arg\" should expand to:";

if ( $cmd_line_arg =~ m/\{([\w\,]*)\}/ ) {
    my @items = split /,/, $1;
    for my $item (@items) {
        my $string = $cmd_line_arg;
        $string =~ s/\{[\w\,]*\}/$item/;
        say $string;
    }
}

