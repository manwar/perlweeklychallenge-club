#!/usr/bin/env perl

use Modern::Perl;

say percent_char(@ARGV);

sub percent_char {
    my($str, $ch) = @_;
    my $percent = 100 * ($str =~ s/$ch/$ch/g) / length($str);
    return int($percent+0.5);
}
