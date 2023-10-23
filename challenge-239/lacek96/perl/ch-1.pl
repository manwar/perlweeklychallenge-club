#!/usr/bin/perl -w
use v5.32;
use strict;
use warnings;

sub areSameStrings 
{
    my ($ArrRef1, $ArrRef2) = @_;
	
	my @array1 = @{$ArrRef1};
	my @array2 = @{$ArrRef2};
	
	my $text1 = join('',@array1);
    my $text2 = join('',@array2);
	
	if ($text1 eq $text2)
	{
		say "true";
	}
	else
	{
		say "false";
	}
}

sub main
{
	my @arr1 = ("ab", "c");
    my @arr2 = ("a", "bc");
	
	my @arr3 = ("ab", "c");
    my @arr4 = ("ac", "b");
	
	my @arr5 = ("ab", "cd", "e");
    my @arr6 = ("abcde");
	
	areSameStrings(\@arr1,\@arr2);
	areSameStrings(\@arr3,\@arr4);
	areSameStrings(\@arr5,\@arr6);
	
}

main();