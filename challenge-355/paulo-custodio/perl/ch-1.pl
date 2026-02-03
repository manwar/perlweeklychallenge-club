#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 && $ARGV[0] =~ /^\d+$/ or die "Usage: $0 integer\n";
say insert_separators(shift);

sub insert_separators {
    my($num) = @_;
    1 while $num =~ s/(\d)(\d\d\d)((,\d\d\d)*)$/$1,$2$3/;
    return $num;
}
