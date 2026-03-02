#!/usr/bin/env perl

use Modern::Perl;
use Getopt::Std;

my %opts;
getopts('d', \%opts) && @ARGV==1 or die "usage: $0 [-d] string\n";
my $string = $ARGV[0];

if ($opts{d}) {
    say decompress($string);
}
else {
    say compress($string);
}

sub compress {
    my($plain) = @_;
    my $compressed = "";

    while ($plain ne '') {
        if ($plain =~ s/^(([a-z])\2{1,8})//i) {
            $compressed .= length($1).$2;
        }
        else {
            $compressed .= substr($plain, 0, 1);
            $plain = substr($plain, 1);
        }
    }
    return $compressed;
}

sub decompress {
    my($compressed) = @_;
    my $plain;

    while ($compressed ne '') {
        if ($compressed =~ s/^(\d)([a-z])//i) {
            $plain .= $2 x $1;
        }
        else {
            $plain .= substr($compressed, 0, 1);
            $compressed = substr($compressed, 1);
        }
    }
    return $plain;
}
