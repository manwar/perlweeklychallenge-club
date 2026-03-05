#!/usr/bin/env perl

use Modern::Perl;

$_ = shift // "";
1 while s/([^\d])(\d+)/ expand($1, $2) /e;
say $_;

sub expand {
    my($ch, $digits) = @_;
    my $out = $ch;
    for my $digit (split //, $digits) {
        $out .= chr(ord($ch)+$digit);
    }
    return $out;
}
