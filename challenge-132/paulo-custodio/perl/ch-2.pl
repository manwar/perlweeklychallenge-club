#!/usr/bin/env perl

# TASK #2 > Hash Join
# Submitted by: Mohammad S Anwar
# Write a script to implement Hash Join algorithm as suggested
# by wikipedia.
# 
# 1. For each tuple r in the build input R
#     1.1 Add r to the in-memory hash table
#     1.2 If the size of the hash table equals the maximum
#         in-memory size:
#         1.2.1 Scan the probe input S, and add matching join
#               tuples to the output relation
#         1.2.2 Reset the hash table, and continue scanning the
#               build input R
# 2. Do a final scan of the probe input S and add the resulting
#    join tuples to the output relation
# Example
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
#     Based on index = 1 of @players_age and 
#     index = 0 of @players_name.
# 
#     20, "Alex",  "Stewart"
#     20, "Alex",  "Jones"
#     18, "Alex",  "Stewart"
#     18, "Alex",  "Jones"
#     28, "Joe",   "Root"
#     28, "Joe",   "Blog"
#     38, "Mike",  "Gatting"
#     18, "Simon", "Duane"

use Modern::Perl;
use Data::Dump 'dump';

my @player_ages = (
    [20, "Alex"  ],
    [28, "Joe"   ],
    [38, "Mike"  ],
    [18, "Alex"  ],
    [25, "David" ],
    [18, "Simon" ],
);
my $player_ages_key = 1;

my @player_names = (
    ["Alex", "Stewart"],
    ["Joe",  "Root"   ],
    ["Mike", "Gatting"],
    ["Joe",  "Blog"   ],
    ["Alex", "Jones"  ],
    ["Simon","Duane"  ],
);
my $player_names_key = 0;

my @result = hash_join(\@player_ages, $player_ages_key,
					   \@player_names, $player_names_key);
for (@result) {
	say join(", ", map {dump($_)} @$_);
}

sub hash_join {
	my($table1, $key1, $table2, $key2) = @_;
	my %build;
	for my $row (@$table1) {
		my $key = $row->[$key1];
		$build{$key} ||= [];
		push @{$build{$key}}, $row;
	}
	my @result;
	for my $row_probe (@$table2) {
		my $key = $row_probe->[$key2];
		for my $row_build (@{$build{$key}}) {
			my @row = (@$row_build, 
					   @{$row_probe}[0..$key2-1, $key2+1..$#$row_probe]);
			push @result, \@row;
		}
	}
	return @result;
}
