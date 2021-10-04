#!/usr/bin/perl
# 
# TASK #2 - Hash Join
# 
# Write a script to implement Hash Join algorithm as suggested by wikipedia.
# 
# 1. For each tuple r in the build input R
#     1.1 Add r to the in-memory hash table
#     1.2 If the size of the hash table equals the maximum in-memory size:
#         1.2.1 Scan the probe input S, and add matching join tuples to
#	        the output relation
#         1.2.2 Reset the hash table, and continue scanning the build input R
# 2. Do a final scan of the probe input S and add the resulting join tuples
#    to the output relation
# 
# Example
# 
# Input:
# 
#     @player_ages = (
#         [20, "Alex"  ],
#         [28, "Joe"   ],
#         [38, "Mike"  ],
#         [18, "Alex"  ],
#         [25, "David" ],
#         [18, "Simon" ],
#     );
# 
#     @player_names = (
#         ["Alex", "Stewart"],
#         ["Joe",  "Root"   ],
#         ["Mike", "Gatting"],
#         ["Joe",  "Blog"   ],
#         ["Alex", "Jones"  ],
#         ["Simon","Duane"  ],
#     );
# 
# Output:
# 
#     Based on index = 1 of @players_age and index = 0 of @players_name.
# 
#     20, "Alex",  "Stewart"
#     20, "Alex",  "Jones"
#     18, "Alex",  "Stewart"
#     18, "Alex",  "Jones"
#     28, "Joe",   "Root"
#     28, "Joe",   "Blog"
#     38, "Mike",  "Gatting"
#     18, "Simon", "Duane"
# 
# MY NOTES: Ok, I think I understand, but I'm going to ignore the
# whole "out of memory" part as that's too complicated.
# Also, I can't see what logical order the example output is ordered by,
# as far as I can see, the described algorithm leads to the order that I
# produce - not the order the above example output shows; so I'm going to
# ignore that too.  After all, in a relation, order doesn't matter, right?
#
# So for the example I build %name2ages containing:
# "Alex" => [20, 18],
# "Joe" => [28],
# "Mike" => [38],
# "David" => [25],
# "Simon" => [18].
# Then use %name2ages while iterating over @player_names.
#
# There's also the question of how to provide the relations,
# (in this file) let's start hard-coding them as arrays of pairs as above,
# but see also ch-2a.pl which generalises them as files.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;

die "Usage: hash-join [-d|--debug]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==0;

my @player_ages = (
	[20, "Alex"  ],
	[28, "Joe"   ],
	[38, "Mike"  ],
	[18, "Alex"  ],
	[25, "David" ],
	[18, "Simon" ],
);

my @player_names = (
	["Alex", "Stewart"],
	["Joe",  "Root"   ],
	["Mike", "Gatting"],
	["Joe",  "Blog"   ],
	["Alex", "Jones"  ],
	["Simon","Duane"  ],
);

#
# my @result = hashjoin( $relation1, $fieldno1, $relation2, $fieldno2 );
#	Do the hash join of two relations $relation1 and $relation2 (each a
#	reference to an array of pairs), on field no $fieldno1 in $relation1
#	with $fieldno2 from $relation2.  Returns an array of pairs.
#
fun hashjoin( $relation1, $fieldno1, $relation2, $fieldno2 )
{
	my %hash;
	foreach my $ref (@$relation1)
	{
		my @r = @$ref;
		my $aref = ($hash{$r[$fieldno1]}//=[]);
		push @$aref, $r[1-$fieldno1];
	}
	#die Dumper \%hash;

	my @result;

	foreach my $ref (@$relation2)
	{
		my @r = @$ref;
		my $key = $r[$fieldno2];
		my $other = $r[1-$fieldno2];
		foreach my $val (@{$hash{$key}})
		{
			push @result, [ $val, $key, $other ];
		}
	}

	return @result;
}


my @result = hashjoin( 
	\@player_ages, 1,
	\@player_names, 0,
	);
say join(', ',@$_) for @result;
