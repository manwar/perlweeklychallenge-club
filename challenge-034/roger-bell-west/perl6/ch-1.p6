#! /usr/bin/perl6

my @data=map {rand}, (1..10);

my @ma=map {sum(@data[$_-1..$_+1])/3}, (1..@data.end-1);

unshift @ma,NaN;
push @ma,NaN;

my @out=map {[@data[$_],@ma[$_]]}, (0..@data.end);

say @out.perl;
