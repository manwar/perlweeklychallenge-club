#!/usr/bin/env perl

use strict;

use warnings;

use Date::Range;

use Date::Simple qw/date today/;

use feature qw/say/;



# AUTHOR: Robert DiCicco

# DATE: 2022-10-17

# Challenge 187 Days Together ( Perl )



my @dates = qw/2022-01-12 2022-01-20 2022-01-15 2022-01-18

               2022-03-02 2022-03-12 2022-03-13 2022-03-14

               2022-03-02 2022-03-12 2022-03-11 2022-03-15

               2022-03-30 2022-04-05 2022-03-28 2022-04-02/;

my @d = ();

my $n = 0;



foreach my $nd (@dates) {

   push(@d,Date::Simple->new($nd));

}



for (my $x=0; $x<scalar(@d); $x+=4){

  my $d1 = Date::Simple->new($d[$x]);

  my $d2 = Date::Simple->new($d[$x+1]);

  my $d3 = Date::Simple->new($d[$x+2]);

  my $d4 = Date::Simple->new($d[$x+3]);



  my $range1 = Date::Range->new($d1, $d2);

  my $range2 = Date::Range->new($d3, $d4);

  say "Bar: SD  $d1  ED: $d2";

  say "Bar: SD  $d3  ED: $d4";



  if ($range1->overlaps($range2)) {

    my $range3 = $range1->overlap($range2);

    $n = 0;

    foreach my $date ($range3->dates) {

      $n++;

    }

  }

  say "Output: $n";

  say " ";

  $n = 0;

}
