#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 str\n";
say good_string($ARGV[0]);

sub good_string {
    my($str) = @_;

    # build a regexp to remove aA and Aa
    my @rex;
    for my $c ('a' .. 'z') {
        push @rex, lc($c).uc($c), uc($c).lc($c);
    }
    my $rex = "(".join("|", @rex).")";

    # remove from string
    1 while $str =~ s/$rex//;

    return $str;
}
