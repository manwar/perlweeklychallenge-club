#!/usr/bin/perl
use warnings;
use strict;

# Following The American Heritage Dictionary of the English Language
# and United States Government Printing Office: midnight is 12:00 am.

sub fun_time {
    my ($h, $m, $p) = $_[0] =~ /([0-9]+):([0-9]+)\s*([ap]m)?/i;
    if ($p) {
        return sprintf '%02d:%02d',
                       $h % 12 + 12 * ($p eq 'pm'),
                       $m
    } else {
        return sprintf '%02d:%02d %sm',
                       $h % 12 || 12,
                       $m,
                       $h >= 12 ? 'p' : 'a'
    }
}

# As a oneliner (does it make any sense?):
# perl -e '($h,$m,$p)=shift=~/(\d+):(\d+)\s*([ap]m)?/i;printf"%02d:%02d"." %sm"x!$p.$/,$p?($h%12+12*(pm eq$p)):($h%12||12),$m,$h>=12?p:a' '12:01 am'

use Test::More tests => 15;

is fun_time('11:10'), '11:10 am', 'plain morning';
is fun_time('06:10'), '06:10 am', 'morning with a leading zero';
is fun_time('20:44'), '08:44 pm', 'afternoon';
is fun_time('00:00'), '12:00 am', 'midnight';
is fun_time('12:00'), '12:00 pm', 'noon';
is fun_time('00:01'), '12:01 am', 'early morning';
is fun_time('12:01'), '12:01 pm', 'early afternoon';

is fun_time('11:10 am'), '11:10', 'plain am';
is fun_time('06:10 am'), '06:10', 'leading zero am';
is fun_time('08:44 pm'), '20:44', 'pm';
is fun_time('12:00 am'), '00:00', 'am midnight';
is fun_time('12:00 pm'), '12:00', 'pm noon';
is fun_time('12:01 am'), '00:01', 'am early morning';
is fun_time('12:01 pm'), '12:01', 'pm early afternoon';
is fun_time('10:59am'),  '10:59', 'no space';
