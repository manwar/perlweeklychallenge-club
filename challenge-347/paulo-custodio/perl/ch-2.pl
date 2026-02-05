#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 phone-num\n";
say format_phone("@ARGV");

sub format_phone {
    my($num) = @_;
    my @out;
    $num =~ s/\D//g;
    while ($num ne '') {
        if (length($num) <= 2) {
            push @out, $num;
            $num = '';
        }
        elsif (length($num) == 4) {
            push @out, substr($num, 0, 2), substr($num, 2, 2);
            $num = '';
        }
        else {
            push @out, substr($num, 0, 3);
            $num = substr($num, 3);
        }
    }
    return join("-", @out);
}
