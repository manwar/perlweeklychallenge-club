#!/usr/bin/env perl

use Modern::Perl;

my @ints = @ARGV;
say digit_count_true(@ints) ? "true" : "false";

sub digit_count_true {
    my(@ints) = @_;
    my %count;
    for (@ints) {
        $count{$_}++;
    }
    for (0 .. $#ints) {
        return 0 if ($count{$_}//0) != $ints[$_];
    }
    return 1;
}
