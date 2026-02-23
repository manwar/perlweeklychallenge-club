#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";
my $str = shift;
say echo($str);

sub echo {
    my($str) = @_;
    my $output;
    for my $i (0 .. length($str)-1) {
        $output .= substr($str, $i, 1) x ($i+1);
    }
    return $output;
}

