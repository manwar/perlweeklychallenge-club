#!/usr/bin/env perl
# Perl weekly challenge 347
# Task 2:  Format Phone Number
#
# See https://wlmb.github.io/2025/11/14/PWC347/#task-2-format-phone-number
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to reformat the telephone numbers Ni,
    each of which contains only digits, dashes and spaces.
    FIN
for(@ARGV){
    try {
        my $input=$_;
        die "Only digits, dashes and spaces allowed: $_" unless /^[-\s\d]+$/;
        tr/- //d; # remove dashes and spaces
        1 while s/(\d{3})(\d{2})/$1-$2/; # make groups of 3 separated by dashes
        s/(\d{2})(\d{2})$/$1-$2/;        # if 4 digits remain divide in two groups
                                         # otherwise, less than four remain, leave alone
        say "$input -> $_";
    }
    catch($e){warn $e}
}
