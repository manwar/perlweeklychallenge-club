#!/usr/bin/env perl

###########################################################################
# script name: ch-2.pl                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-049/         #
#                                                                         #
# LRU Cache                                                               #
# Write a script to demonstrate LRU Cache feature. It should support      #
# operations get and set. Accept the capacity of the LRU Cache as         #
# command line argument.                                                  #
#                                                                         #
# Definition of LRU: An access to an item is defined as a get or a set    #
# operation of the Least recently  item is the one with the oldest access #
# time.                                                                   #
#                                                                         #
###########################################################################

use strict;
use warnings;
use FindBin;
use Term::ReadLine;

my $term = Term::ReadLine->new('input');
$term->ornaments(00,00,00,00);

if ( scalar @ARGV < 1 ) {
    print STDERR "$FindBin::Script requires one argument to assign LRU's capacity, but none was given.\n";
    exit(1);
}

my $CAPACITY = $ARGV[0];

if ($CAPACITY !~ m{\A\d+\Z}) {
    print STDERR "Command line argument assigns capacity. It should be an integer.\n";
    exit(1);
} else {
    print "capacity = $CAPACITY\n";
}

my @cIndex    = ();
my %cache     = ();

sub showCache {
    print "[Least recently used] ";
    for (my $i=0;$i <= $#cIndex; ++$i) {
        print $cIndex[$i];
        $i == $#cIndex
            ? print " "
                : print ", ";
    }
    print "[most recently used]\n\n";
}

sub lruSet {
    my $lruPos = $_[0];
    my $lruVal = $_[1];

    if (exists($cache{$lruPos})) {
        print "position $lruPos currently occupied in cache\n\n";
    } else {
        push @cIndex, $lruPos;
        $cache{$lruPos} = $lruVal;

        if ( scalar @cIndex == $CAPACITY ) {
            print "\nCache at this point:\n";

            showCache;
        } elsif ( scalar @cIndex > $CAPACITY ) {
            my $shifted = shift @cIndex;
            delete $cache{$shifted};
            print "Cache is full, so pushes out key = $shifted:\n";
            showCache;
        }
    }
}

sub lruGet {
    my $lruInd = $_[0];

    my $lruGetRet = -1;

    if (exists($cache{$lruInd})) {

        my $moveElement;
      FIND:
        for (my $j = 0;$j <= $#cIndex; ++$j) {
            if ( $cIndex[$j] == $lruInd ) {
                $moveElement = $j;
                last FIND;
            }
        }
        if ($moveElement != $#cIndex) {
            my $toPush = splice @cIndex,$moveElement, 1;
            push @cIndex, $toPush;
        }

        $lruGetRet = $cache{$lruInd};
    }

    return $lruGetRet;
}

ILOOP:
while (1) {
    my $cmd = $term->readline("");

    if ($cmd =~ m{x|q|exit|quit}i) {

        last ILOOP;

    } elsif ( $cmd =~ m{s(?:et)?[( ]?(\d+)\)?(?:\s+|\,)[( ]?(\d+)\)?}i ) {

        lruSet($1,$2);

    } elsif ( $cmd =~ m{g(?:et)?[( ]?(\d+)\)?}i ) {

        my $lruRet = lruGet($1);

        if ($lruRet == -1) {
            print "            # returns -1\n\nCache unchanged:\n";
        } else {
            print "            # returns $lruRet\n\nCache looks like now:\n";
        }

        showCache;

    } else {
        print STDERR "\nunrecognized input: $cmd\nset(#,#) get(#), exit, quit, x, q are valid inputs\n\n";
    }
}
