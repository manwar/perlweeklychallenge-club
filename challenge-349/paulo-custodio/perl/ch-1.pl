#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";
say power_str($ARGV[0]);

sub power_str {
    my($str) = @_;
    my $max = 0;
    while ($str =~ /((.)\2*)/g) {
        my $len = length($1);
        $max = $len if $max < $len;
    }
    return $max;
}
