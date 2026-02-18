#!/usr/bin/env perl

use Modern::Perl;

@ARGV==2 or die "usage: $0 str1 str2\n";
say is_friendly(@ARGV) ? "true" : "false";

sub is_friendly {
    my($str1, $str2) = @_;
    for my $i (0 .. length($str1)-2) {
        for my $j ($i+1 .. length($str1)-1) {
            my $cmp1 = substr($str1, 0, $i).
                       substr($str1, $j, 1).
                       substr($str1, $i+1, $j-$i-1).
                       substr($str1, $i, 1).
                       substr($str1, $j+1);
            return 1 if $cmp1 eq $str2;
        }
    }
    return 0;
}
