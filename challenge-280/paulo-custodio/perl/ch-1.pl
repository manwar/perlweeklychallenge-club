#!/usr/bin/env perl

use Modern::Perl;

my $str = shift || "";
say double_letter($str);

sub double_letter {
    my($str) = @_;

    my %found;
    for (split //, $str) {
        return $_ if $found{$_}++;
    }
    return "";
}
