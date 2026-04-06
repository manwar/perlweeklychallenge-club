#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    my $count0 = y/0//;
    my $count1 = y/1//;
    say "1" x ($count1 - 1), "0" x $count0, "1";
}

__END__
