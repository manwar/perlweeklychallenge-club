#!/usr/bin/perl

# Challenge 029

# Task #1
# Write a script to demonstrate brace expansion. For example, script would take
# command line argument Perl {Daily,Weekly,Monthly,Yearly} Challenge and should
# expand it and print like below:
#
#   Perl Daily Challenge
#   Perl Weekly Challenge
#   Perl Monthly Challenge
#   Perl Yearly Challenge

use Modern::Perl;

sub print_expanded {
    my($text) = @_;
    if ($text =~ /[{]([^{}]*?)[}]/) {
        my($before, $expand, $after) = ($`, $1, $');
        for my $arg (split(/,/, $expand)) {
            print_expanded($before.$arg.$after);
        }
    }
    else {
        say $text;
    }
}

print_expanded("@ARGV");
