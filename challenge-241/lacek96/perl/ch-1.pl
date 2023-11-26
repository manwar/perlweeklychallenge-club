#!/usr/bin/perl -w
use v5.32;
use strict;
use warnings;

sub triplets
{
	my ($diff,$arrRef) = @_;
	
	my @array = @{$arrRef};
	
	my $array_size = $#array + 1;
	
	my $i;
	my $j;
	my $k;
	
	my $triplets = 0;
	
	for ($k = 0; $k < $array_size; $k++)
	{
		for ($j = 0; $j < $k; $j++)
		{
			for ($i = 0; $i < $j; $i++)
			{
				if (($array[$j] - $array[$i] == $diff) && ($array[$k] - $array[$j] == $diff))
				{
					say "Index ($i,$j,$k) are arithmetic triplet, because both $array[$k] - $array[$j] == $diff and $array[$j] - $array[$i] == $diff.";
					$triplets++;
				}
			}
		}
	}
	say "Number of triplets: $triplets\n";
}

sub main
{
	my @nums1 = (0, 1, 4, 6, 7, 10);
	my @nums2 = (4, 5, 6, 7, 8, 9);
	
	triplets(3,\@nums1);
	triplets(2,\@nums2);
}

main();