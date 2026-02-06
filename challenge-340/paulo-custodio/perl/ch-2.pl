#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 words\n";
say is_ascending(split ' ', "@ARGV") ? "true" : "false";

sub is_ascending {
    my(@words) = @_;
    my @nums = grep {/^[1-9]\d*$/} @words;
    for my $i (1 .. $#nums) {
        return unless $nums[$i] > $nums[$i-1];
    }
    return 1;
}
