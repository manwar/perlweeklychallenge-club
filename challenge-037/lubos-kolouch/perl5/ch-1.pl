## Please see file perltidy.ERR
#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-037/
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 20.10.2019
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;
use DateTime;
use Data::Dumper;

my $dt = DateTime->new(
    year  => 2019,
    month => 1,
    day   => 1
);


my %month;

while ($dt->year == 2019) {
   $month{$dt->month}++ if ($dt->day_of_week < 6);

   $dt->add(days => 1);
}

warn Dumper \%month;
