#!/usr/bin/env perl

use Modern::Perl;

@ARGV==2 or die "usage: $0 str num\n";
say encrypt(@ARGV);

sub encrypt {
    my($str, $num) = @_;
    $str = lc($str);
    $str =~ s/[^a-z]//g;
    my @str_codes = map {ord($_) - ord('a')} split(//, $str);
    my @coded = map { ($_ + 26 + $num) % 26 } @str_codes;
    return join '', map {chr($_ + ord('a'))} @coded;
}
