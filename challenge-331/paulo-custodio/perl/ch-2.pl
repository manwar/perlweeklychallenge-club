#!/usr/bin/env perl

use Modern::Perl;

@ARGV==2 or die "usage: $0 source target\n";
say are_buddies(@ARGV) ? "true" : "false";

sub are_buddies {
    my($source, $target) = @_;
    my @source = split //, $source;
    for my $i (0 .. $#source-1) {
        for my $j ($i+1 .. $#source) {
            my @new = @source;
            @new[$i, $j] = @new[$j, $i];
            return 1 if $target eq join '', @new;
        }
    }
    return 0;
}
