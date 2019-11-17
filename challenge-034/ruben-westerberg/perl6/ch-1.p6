#!/usr/bin/env perl6

#Demonstate array and hash slicing
my @array=(0,1,2,3,4,5,6,7,8,9);
my %hash=(a=>0, b=>1, c=>2, e=>3);
say "Original Array: \n", @array;
say "Original Hash \n",%hash; 

say "Slicing Array with a range [0..3]: ";
say @array[0..3];

say "Slicing Array with duplicate index [0,0]: ";
say @array[0,0];


say 'Slicing hash into another hash %hash{qw<a b>}:kv.hash : ';
say %hash{qw<a b>}:kv.hash;

say 'Slicing hash in to value array %hash{qw<a b>}: ';
say %hash{qw<a b>};
