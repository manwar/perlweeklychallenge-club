#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 str";
say "(", join(", ", find_groups($ARGV[0])), ")";

sub find_groups {
    my($str) = @_;
    my @groups;
    while ($str =~ /((\w)\2{2,})/g) {
        push @groups, $1;
    }
    return @groups;
}
