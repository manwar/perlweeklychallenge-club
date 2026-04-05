#! /usr/bin/env raku

unit sub MAIN ($event1, $event2, :v($verbose));

grammar Event
{
  token TOP       { <hhmm> <space> <hhmm> }
  token hhmm      { <hh> <colon> <mm>  }
  token space     { \s }
  token colon     { ":" }
  token hh        { <[01]> <[0..9]> | 20 | 21 | 22 | 23 }
  token mm        { <[012345]> <[0..9]> }
}

my $e1 = Event.parse($event1);
my $e2 = Event.parse($event2);

die "Illegal syntax in 1. event" unless $e1;
die "Illegal syntax in 2. event" unless $e2;

my $start1 = $e1<hhmm>[0]<hh> * 60 + $e1<hhmm>[0]<mm>;
my $stop1  = $e1<hhmm>[1]<hh> * 60 + $e1<hhmm>[1]<mm>;
my $start2 = $e2<hhmm>[0]<hh> * 60 + $e2<hhmm>[0]<mm>;
my $stop2  = $e2<hhmm>[1]<hh> * 60 + $e2<hhmm>[1]<mm>;

if $start1 > $start2
{
  ($start1, $stop1, $start2, $stop2) = ($start2, $stop2, $start1, $stop1);
  say ": Swapped event 1 & 2 so that 1 starts first" if $verbose;
}

my $overnight1 = $start1 > $stop1;
my $overnight2 = $start2 > $stop2;

if $verbose
{
  say ": Event1: $start1 - $stop1 Overnight:$overnight1";
  say ": Event2: $start2 - $stop2 Overnight:$overnight2";
}

if $overnight1 == $overnight2 == True
{
  say True;
}

elsif $overnight1 == $overnight2 == False
{
  say $start2 < $stop1;
}

elsif $overnight1 == True
{
  say ( $stop1 > $start2 || $start1 < $stop2 );
}

elsif $overnight2 == True
{
  say ( $stop2 > $start1 || $start2 < $stop1 );
}

