#!/usr/bin/perl
# 
# TASK #2a - Hash Join (with relations read from files)
# 
# Write a script to implement Hash Join algorithm as suggested by wikipedia.
# This version reads the relations from CSV-formatted files, which contain
# the fieldnames in row 1.
# 
# 1. For each tuple r in the build input R
#     1.1 Add r to the in-memory hash table
# 2. Do a final scan of the probe input S and add the resulting join tuples
#    to the output relation
# 
# Example
# 
# Input:
# 
#     ages:
#	  age,forename
#         20,"Alex"
#         28,"Joe"
#         38,"Mike"
#         18,"Alex"
#         25,"David"
#         18,"Simon"
# 
#     names:
#	  forename,surname
#         "Alex","Stewart"
#         "Joe","Root"
#         "Mike","Gatting"
#         "Joe","Blog"
#         "Alex","Jones"
#         "Simon","Duane"
# 
# Output:
# 
#     Join based on forename fields
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

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use List::Util qw(first);
use Data::Dumper;
use Text::CSV;

my $debug = 0;

die "Usage: hash-join [-d|--debug] relation1 fieldname1 relation2 [fieldname2]\n"
	unless GetOptions( "debug"=>\$debug ) && (@ARGV==3 || @ARGV==4);
my( $relname1, $field1, $relname2, $field2 ) = @ARGV;
$field2 //= $field1;		# reuse same fieldname if fieldname2 omitted


#
# my @relation = read_relation( $relname );
#	Read a relation from file $relname, and return the array of rows.
#
fun read_relation( $relname )
{
	my $csv = Text::CSV->new();
	open( my $fh, '<', $relname ) || die "can't open $relname\n";
	my @rows;
	while( my $row = $csv->getline ($fh) )
	{
		#die Dumper \$row;
		push @rows, $row;
	}
	close $fh;
	return @rows;
}


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


my @player_ages = read_relation( $relname1 );
#die Dumper \@player_ages;
my @age_fields = @{shift @player_ages};
my $fieldno1 = first { $age_fields[$_] eq $field1 } 0..$#age_fields;
say "fieldno1($field1)=$fieldno1" if $debug;

my @player_names = read_relation( $relname2 );
my @name_fields = @{shift @player_names};
my $fieldno2 = first { $name_fields[$_] eq $field2 } 0..$#name_fields;
say "fieldno2($field2)=$fieldno2" if $debug;

my @result = hashjoin( 
	\@player_ages, $fieldno1,
	\@player_names, $fieldno2,
	);
say join(', ',@$_) for @result;
