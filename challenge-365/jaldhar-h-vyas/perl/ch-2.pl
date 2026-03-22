#!/usr/bin/perl
use 5.038;
use warnings;
use builtin qw/ true false /;
no warnings qw/ experimental::builtin /;

sub isValidToken($token) {

    my $digit = qr/\d/;
    if ($token =~ /$digit/) {
        return false;
    }

    my $hyphen = qr/-/;
    if ($token =~ /($hyphen)/g &&
    (scalar @{^CAPTURE} != 1 || $token !~ /[[:lower:]]$hyphen[[:lower:]]/)) {
        return false;
    }

    my $punct = qr/[!.,]/;
    if ($token =~ /($punct)/g && (scalar @{^CAPTURE} != 1 || $token !~ /$punct$/)) {
        return false;
    }

    return true;
}

my ($str) = @ARGV;

say scalar grep { isValidToken($_) } split /\s+/, $str;