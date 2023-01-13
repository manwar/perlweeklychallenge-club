#!/usr/bin/env perl

=begin

AUTHOR: Robert DiCicco

DATE  : 2023-01-12

Challenge 199 Good Triplets ( Perl )

=cut

use strict;

use warnings;

use Algorithm::Permute;

use List::MoreUtils qw/indexes/;

 

my %seen = ();

 

my @list = (3,0,1,1,9,7);

my $x = 7;

my $y = 2;

my $z = 3;

 

# my @list = (1,1,2,2,3);

# my $x = 0;

# my $y = 0;

# my $z = 1;

 

 

my $anchor = 0;

my $cnt = 0;

 

sub TestArray {

                my ($first, $second, $third) = @_;

                my @x1 = indexes { $_ == $first } (@list);

                my @x2 = indexes { $_ == $second } (@list);

                my @x3 = indexes { $_ == $third } (@list);

                if (($x1[0] > $x2[0]) || ($x2[0] > $x3[0]) || ($x1[0] > $x3[0]) ){

                                return -1;

                }

                if (abs($first - $second) > $x) { return -1};

                if (abs($second - $third) > $y) { return -1};

                if (abs($first  - $third) > $z) { return -1};

                return 1;

}

my $sz = @list;

my $p = Algorithm::Permute->new(\@list,3);

while (my @res = $p->next) {

                my $retval = TestArray(@res);

                my $combined = "$res[0]$res[1]$res[2]";

                if ($retval == 1) {

                                if (! $seen{$combined}){

                                                $seen{$combined} = 1;

                                } else {

                                                print "$res[0], $res[1], $res[2]\n";

                                }

                }

}

=begin

SAMPLE OUTPUT

perl .\GoodTriplets.pl

0, 1, 1

3, 1, 1

3, 0, 1

=cut
