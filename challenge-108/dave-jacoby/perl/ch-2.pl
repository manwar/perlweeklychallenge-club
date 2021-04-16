#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use List::Util qw{uniq};
use Getopt::Long;
use JSON;
my $json = JSON->new->space_before->space_after;

# since I already use Getopt::Long, I might want to 
# modify this so I can independently run higher numbers
# and time them. i => bell(i) grows exponentially.
my $verbose = 0;
GetOptions( 'verbose' => \$verbose );

# Write a script to display top 10 Bell Numbers
my @alphabet = 'a' .. 'z';
unshift @alphabet, '';
my %test = (
    0 => 1,
    1 => 1,
    2 => 2,
    3 => 5,
    4 => 15,
    5 => 52,
    6 => 203,
    7 => 877,
    8 => 4140,
    9 => 21147
);

my %filter;

for my $n ( 0 .. 9 ) {
    %filter = ();
    my @set = grep { length $_ } @alphabet[ 0 .. $n ];
    my $t   = $test{$n};
    my ( $bell, @list ) = bell_number(@set);
    say join ' - ',      $n, $verbose, $t, $bell, join ',', @set;
    say join "\n\t$n\t", '', @list, '' if $verbose;
    say join ' - ',      $n, $verbose, $t, $bell, join ',', @set;
    say '';
}
exit;

# We're MOSTLY expected to get the bell number, which is
# the number of unique partitions -- [[a],[b]] == [[b],[a]] --
# so I do some of the administrivia in bell_number() and
# do the bulk of the work in _bell_number().

# in my first pass, I got myself confused with adding
# second-level arrays as needed, so instead, I start with
# a larger-than-needed set of arrays and fill from there.

# The first ten bell numbers are:
# 1,
# 1,
# 2,
# 5,
# 15,
# 52,
# 203,
# 877,
# 4140

# The key, then, is to grep filled arrays, because
#   [],[],[],[a]
# is equivalent to
#   [a]
# and sort by initial entry, because
#   [a,b],[c]
# is equivalent to
#   [c],[a,b]

# We now stringify the arrayref to JSON with encode, and
# between filtering and uniq, ensure that it doesn't get
# TOO big, otherwise this segfaults at n=8 or so.

# the question ASKS for the Bell number, but the examples
# show all the partitions that go into that, so...

sub bell_number( @set ) {
    return 1, [] unless scalar @set;

    @set = sort @set; # just making sure
    my @partitions;
    for ( 0 .. scalar @set ) { push @partitions, [] }
    my @output = _bell_number( \@set, \@partitions );
    return ( scalar @output, @output );
}

# THIS looks like a JOB for RECURSION!

# I will have to read the other options to see who did this
# iteratively.

# we pass the arrays for set (the letters left) and 
# partitions (the partitions created so far), because
# you can't pass arrays otherwise, but one list.

# Because passing by name, not by value, I make a copy 
# of the set and work off the copy.

# I could see wanting to Memoize this, but I don't think
# there could be much effect without going into internals.
sub _bell_number ( $set, $partitions ) {
    my @output;
    my $set2->@* = map { $_ } $set->@*;
    my $l = shift $set2->@*;

    # We handle for every bucket
    # The more buckets, the more problems

    # We make a copy of the partitions for each bucket
    # and work off that, rather than trying to clean up
    # manually each time.

    # Given trying to put A in when the starting set is
    # [A,B,C,D], the first partitions would be

    # [ A ],[   ],[   ],[   ]
    # [   ],[ A ],[   ],[   ]
    # [   ],[   ],[ A ],[   ]
    # [   ],[   ],[   ],[ A ]

    # I have questions about whether this is the most 
    # efficient code, because of all the built-in replication
    # of results, but a better way isn't immediately 
    # obvious to me.

    for my $i ( 0 .. -1 + scalar $partitions->@* ) {
        my $prt->@* = map { [@$_] } $partitions->@*;
        push $prt->[$i]->@*, $l;

        # If there are more letters to use, we we go 
        # again
        if ( scalar $set2->@* ) {
            push @output, _bell_number( $set2, $prt );
        }

        # if there are no more letters in the set,
        # that means we're done. $prt2 is a cleaner
        # version of $prt, and $prtj is the stringified
        # version of that partition set. There's a hash 
        # meant to keep duplicates from being put into 
        # the output, but...
        else {
            my $prt2->@* =
                sort { $a->[0] cmp $b->[0] }
                grep { scalar $_->@* }
                map  { [@$_] } $prt->@*;
            my $prtj = $json->encode($prt2);
            $filter{$prtj}++;
            push @output, $prtj unless $filter{$prtj} < 2;
        }
    }

    # It's also handled by uniq. Becasuse we're sorting
    # by first element and grepping out empty partitions, 
    # we will never get two representations of the same set,
    # so uniq will bring it down to the minimum.
    @output = uniq @output;
    return @output;
}

