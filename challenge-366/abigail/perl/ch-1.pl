#!/opt/perl/bin/perl

#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-366/
#

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    #
    # Read the data; each line is an exercise. "" indicates an empty entry
    # 
    my ($s => @array) = map {s/"+//gr} split;
    say scalar grep {!index $s => $_} @array;
}

__END__
