#!/usr/bin/env perl
use Modern::Perl;

# Write a script to demonstrate brace expansion. For example, script
# would take command line argument Perl {Daily,Weekly,Monthly,Yearly}
# Challenge and should expand it and print like below:
#
#  Perl Daily Challenge
#  Perl Weekly Challenge
#  Perl Monthly Challenge
#  Perl Yearly Challenge

my $input = shift;

# identify the braces in the input string
my ($brace) = $input =~ m/\{(.+?)\}/;

unless ($brace) {
    say $input;
    exit;
}

# split brace content into its expansions
my @expansions = split ',', $brace;

# replace the brace with the expansion
for my $expansion (@expansions) {
    ( my $output = $input ) =~ s/(\{.+?\})/$expansion/;
    say $output;
}

# ideas for extension of the task:
# - support for multiple braces in command line argument