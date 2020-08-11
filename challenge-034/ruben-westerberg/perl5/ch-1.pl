#!/usr/bin/env perl

#Demonstate array and hash slicing
my @array=(0,1,2,3,4,5,6,7,8,9);
my %hash=(a=>0, b=>1, c=>2, e=>3);
print "Original Array: ". join(", ",@array) ."\n";
print "Original Hash ". join(", ",%hash) ."\n";

print "Slicing Array with a range [0..3]: ";
print join(",", @array[0..3]),"\n";

print "Slicing Array with duplicate index [0,0]: ";
print join(",", @array[0,0]),"\n";


print "Slicing hash into another hash %hash{qw<a b>}: ";
print join(",", %hash{qw<a b>}),"\n";

print 'Slicing hash in to value array @hash{qw<a b>}: ';
print join ",", @hash{qw<a b>};

