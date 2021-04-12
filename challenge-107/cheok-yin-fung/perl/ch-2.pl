#!/usr/bin/perl
# The Weekly Challenge 107 
# Task 2 List Methods
# ---
# Note: I would like to check the syntax of the program first. But
# my $test_return = `perl -c $program`; 
# Why is $test_return empty? Where can I get the return of perl -c ?
# ---
# Usage:  ch-2.pl [complete name of the script]


die "Please input Perl scripts you want to check.\n" if !defined($ARGV[0]);

my $program = $ARGV[0];

open(SCRIPT, $program) or die "Fail to read $program\n";

my %hash;

while (my $line = <SCRIPT>) {
    while ( $line =~ /sub(\s+)(\&|\w)(\w*)/g ) {
        print $2.$3."\n";
    } 
}

#ref: https://stackoverflow.com/questions/9156149/perl-match-one-pattern-multiple-times-in-the-same-line-delimited-by-unknown-cha
