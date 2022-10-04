#!/bin/sh

raku -e '@*ARGS.map({my $temp=$_; ($temp ~~ s/<[a .. w y z 0 .. 9]>/x/) for (0 .. 3); say $temp;})' 'ab-cde-123' '123.abc.420' '3abc-0010.xy'

#raku -e '@*ARGS.map({my $temp=$_; ($temp ~~ s/<[a .. w y z 0 .. 9]>/x/) for (0 .. 3); say $temp;})' '1234567.a' 'a-1234-bc' 'a.b.c.d.e.f'



