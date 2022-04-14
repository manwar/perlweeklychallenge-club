#!/usr/bin/env perl

# Challenge 062
#
# TASK #1 › Sort Email Addresses
# Submitted by: Neil Bowers
# Reviewed by: Ryan Thompson
#
# Write a script that takes a list of email addresses (one per line) and sorts
# them first by the domain part of the email address, and then by the part to
# the left of the @ (known as the mailbox).
#
# Note that the domain is case-insensitive, while the mailbox part is case
# sensitive. (Some email providers choose to ignore case, but that’s another
# matter entirely.)
#
# If your script is invoked with arguments, it should treat them as file names
# and read them in order, otherwise your script should read email addresses from
# standard input.
#
# Bonus
# Add a -u option which only includes unique email addresses in the output, just
# like sort -u.
#
# Example
# If given the following list:
#
# name@example.org
# rjt@cpan.org
# Name@example.org
# rjt@CPAN.org
# user@alpha.example.org
# Your script (without -u) would return:
#
# user@alpha.example.org
# rjt@cpan.org
# rjt@CPAN.org
# Name@example.org
# name@example.org
# With -u, the script would return:
#
# user@alpha.example.org
# rjt@CPAN.org
# Name@example.org
# name@example.org

use Modern::Perl;
use Getopt::Std;

our $opt_u;
getopts('u');
chomp(my @mails = <>);

my @sorted =
    map {join '@', @$_}                     # join mailbox and domain
    sort {lc($a->[1]) cmp lc($b->[1])}      # sort domain case insensitive
    sort {$a->[0] cmp $b->[0]}              # sort mailbox
    map {[split '@', $_]}                   # split mailbox and domain
    @mails;

if ($opt_u) {
    my %seen;
    @sorted =
        map {join '@', @$_}                 # join mailbox and domain
        grep {my $key = $_->[0].'@'.lc($_->[1]);
              !$seen{$key}++}               # filter only not seen
        map {[split '@', $_]}               # split mailbox and domain
        @sorted;
}

say join("\n", @sorted);
