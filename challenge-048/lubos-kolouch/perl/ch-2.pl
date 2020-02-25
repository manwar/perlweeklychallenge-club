#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/
#
#               Palindrome Dates
#
#               Write a script to print all Palindrome Dates between 2000 and 2999. The format of date is mmddyyyy. For example, the first one was on October 2, 2001 as it is represented as 10022001.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/22/2020 10:11:25 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use DateTime;
use feature qw/say/;

sub is_palindrome {
    my $dt = shift;

    return 1 if $dt->mdy('') eq reverse $dt->mdy('');

    return 0;
}

my $dt_start = DateTime->new( year => 2000, month => 1, day => 1 );
my $epoch_test = $dt_start->epoch;

my $dt_end = DateTime->new( year => 2999, month => 12, day => 31 );
my $epoch_end = $dt_end->epoch;

while ($epoch_test < $epoch_end) {
    my $dt = DateTime->from_epoch( epoch => $epoch_test);

    say $dt->mdy if is_palindrome($dt);
    $epoch_test += 60 * 60 * 24;
}

