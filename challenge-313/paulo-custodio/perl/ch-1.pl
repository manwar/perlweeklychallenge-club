#!/usr/bin/env perl

use Modern::Perl;

say is_typed(@ARGV) ? "true" : "false";

sub is_typed {
    my($string, $got) = @_;
    (my $match = $string) =~ s/(.)/$1+/g;
    return $got =~ /$match/;
}
