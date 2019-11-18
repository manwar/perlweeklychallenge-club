#!/usr/bin/env perl

#Build dispatch table of functions
my @dispatch=map { my $i=$_;sub { templateSub($i)}} 1..10;

#Randomly execute entries in the the table
&{$dispatch[int rand @dispatch]} for (@dispatch);

#Template function
sub templateSub {
	print  "Hello from sub @_\n"
}

