#!/usr/bin/env perl

# Challenge 107
#
# TASK #2 - List Methods
# Submitted by: Mohammad S Anwar
# Write a script to list methods of a package/class.
#
# Example
# package Calc;
#
# use strict;
# use warnings;
#
# sub new { bless {}, shift; }
# sub add { }
# sub mul { }
# sub div { }
#
# 1;
# Output
# BEGIN
# mul
# div
# new
# add

use Modern::Perl;
{
    package Calc;
    sub new { bless {}, shift; }
    sub add { }
    sub mul { }
    sub div { }
}

show_methods('Calc');

sub show_methods {
    my($package) = @_;
    no strict 'refs';
    for my $symbol (sort keys %{$package."::"}) {
        say $symbol if exists &{$package."::".$symbol};
    }
}
