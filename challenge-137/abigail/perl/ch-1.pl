#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# The Gregorian calender cycles every 400 years. That is, every calender
# event, or sequence of calender events, repeats after 400 years.
# (This is because there are 97 leap days in a 400 year period, which
# means there are 146097 days in such a period, and 146097 days are
# exactly 20871 weeks).
#

#
# In such a 400 year period, there are 71 long years. A long year
# starts or ends with a Thursday (a non-leap long year starts and
# ends with with a Thursday, a leap long year either starts with
# a Wednesday and ends with a Thursday, or starts with a Thursday,
# and end with a Friday).
#

# 
# Now, we could calculate the day of the week of Jan 1 and Dec 31,
# either using a module or some handrolled calculations, checking
# whether at least of those days is a Thursday.
#
# Or we could just list the 71 years in a 400 year period, and so
# some trivial arithmetic.
#
# Guess which method we're using.
#

my @long_year_offsets = qw [
    004     009     015     020     026
    032     037     043     048     054
    060     065     071     076     082
    088     093     099             
            105     111     116     122
    128     133     139     144     150
    156     161     167     172     178
    184     189     195             
            201     207     212     218
    224     229     235     240     246
    252     257     263     268     274
    280     285     291     296     
                    303     308     314
    320     325     331     336     342
    348     353     359     364     370
    376     381     387     392     398
];

say for grep {1900  <= $_ <= 2100}
         map {my $fy = $_; map {$_ + $fy} @long_year_offsets} 1600, 2000;
