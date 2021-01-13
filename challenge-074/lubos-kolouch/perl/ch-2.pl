#
#!/usr/bin/perl 
#===============================================================================
#
#҄         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-074/
#
#               TASK #2 › FNR Character
#
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 08/22/2020 12:40:09 PM
#===============================================================================

use strict;
use warnings;
use List::MoreUtils qw/firstidx/;
use feature qw/say/;
use Data::Dumper;

sub get_fnr {
    my $input = shift;

    my %fnr_count;
    my @fnr_queue;

    my $result;

    for (split //, $input) {
        my $char = $_;

        $fnr_count{$_}++;

        if ($fnr_count{$_} == 1) {
            push @fnr_queue, $_;
        } else {
            my $pos = firstidx { $_ eq $char }   @fnr_queue;
            splice @fnr_queue, $pos, 1 if defined $pos;
        }

        $result .= scalar @fnr_queue? $fnr_queue[-1] : '#'; 
    }

    return $result;

}

use Test::More;

is(get_fnr('ababc'),'abb#c');
is(get_fnr('xyzzyx'),'xyzyx#');

done_testing;
