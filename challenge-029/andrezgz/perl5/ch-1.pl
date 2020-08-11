#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-029/
# Task #1
# Write a script to demonstrate brace expansion. For example, script would take command line argument
# Perl {Daily,Weekly,Monthly,Yearly} Challenge and should expand it and print like below:
#  Perl Daily Challenge
#  Perl Weekly Challenge
#  Perl Monthly Challenge
#  Perl Yearly Challenge

use strict;
use warnings;

sub expand {
    my $input = shift;
    my %expansions;

    if ($input =~ m/ (.*?)           # optional preamble
                     \{ ([^{}]*?) \} # pair of braces that not contain braces inside
                     (.*)            # optional postscript
                    /x ) {

        my ($preamble, $brace_match, $postscript) = ($1,$2,$3);
        $brace_match = adjust_range($brace_match);

        foreach my $item ( split /,/, $brace_match ) {
            foreach ( expand( $preamble . $item . $postscript ) ) {
                $expansions{$_} = 1; #unique expansions
            }
        }
    }

    return %expansions ? sort keys %expansions : ($input);
}

# replace range with list of values
sub adjust_range {
    my $brace_exp = shift;
    return join ',', ($1..$2) if ( $brace_exp =~ /^(\d+)[.]{2}(\d+)$/ );        # numeric range n..m
    return join ',', ($1..$2) if ( $brace_exp =~ /^([a-z]+)[.]{2}([a-z]+)$/i ); # alphabetic range a..z
    return $brace_exp; # unmodified, no range detected
}

while (<DATA>) {
    chomp;
    print "Expansion for: '$_'\n";
    print join "\n", expand($_);
    print "\n\n";
}

__DATA__
last{mce,boot,xorg}.log
file.{2015..2017}.{a..c}.log{,.bak}
/home/tom/{temp,tmp{1..4}}/image.{jpg,png}
Perl {{Dai,Week,Month,Year}ly,Unique} Challenge
