#!/usr/bin/env perl

use Modern::Perl;
use List::Util 'max';

say max(map {str_value($_)} @ARGV);

sub str_value {
    my($str) = @_;
    if ($str =~ /^\d+$/) {
        return 0+$str;
    }
    else {
        return length($str);
    }
}
