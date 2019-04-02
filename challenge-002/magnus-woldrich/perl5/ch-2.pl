#!/usr/bin/perl
# vim: ft=perl:fdm=marker:fmr=#<,#>:fen:et:sw=2:
use strict;
use warnings FATAL => 'all';


print for map { sprintf "%d\n", $_ } @ARGV ? @ARGV : (@ARGV = readline);

__END__

$ printf "%02d\n%04d\n%042d\n" 1 2 3 | perl challenge-02.pl
1
2
3
