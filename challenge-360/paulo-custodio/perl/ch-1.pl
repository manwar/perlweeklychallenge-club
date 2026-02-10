#!/usr/bin/env perl

use Modern::Perl;

@ARGV==2 or die "usage: $0 string padding\n";
say padded(@ARGV);

sub padded {
    my($str, $n) = @_;
    my $out = "*" x int(($n - length($str)) / 2);
    $out .= $str;
    $out .= "*" x ($n - length($out));
    return $out;
}
