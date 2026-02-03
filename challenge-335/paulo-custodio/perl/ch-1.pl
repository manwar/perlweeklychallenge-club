#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 words...\n";
say join " ", common_letters(@ARGV);

sub common_letters {
    my($word, @others) = @_;
    my @common;
    for my $c (split //, $word) {
        my $count = 0;
        for (@others) {
            $count++ if s/$c//;
        }
        push @common, $c if $count == @others;
    }
    return @common;
}
