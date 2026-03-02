#!/usr/bin/env perl

use Modern::Perl;

sub is_luhn {
    my($str) = @_;
    $str =~ s/\D//g;
    my $payload = 0+substr($str, -1, 1);
    my $sum = 0;
    my $factor = 2;
    for (my $i = length($str)-2; $i >= 0; $i--) {
        my $digit = $factor*substr($str, $i, 1);
        if ($digit > 9) {
            $sum += eval(join("+", split //, $digit));
        }
        else {
            $sum += $digit;
        }
        $factor = 3-$factor;
    }
    if (($sum + $payload) % 10 == 0) {
        return 1;
    }
    else {
        return 0;
    }
}

say is_luhn("@ARGV") ? "true" : "false";
