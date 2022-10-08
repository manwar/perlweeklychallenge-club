#!/bin/sh

perl -E 'for my $test (@ARGV) {$test =~ s/[a-wyz0-9]/x/ for (1 .. 4); say $test}' 'ab-cde-123' '123.abc.420' '3abc-0010.xy'

#perl -E 'for my $test (@ARGV) {$test =~ s/[a-wyz0-9]/x/ for (1 .. 4); say $test}' '1234567.a' 'a-1234-bc' 'a.b.c.d.e.f'
