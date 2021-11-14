#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to implement Hash Join algorithm as suggested by wikipedia.
1. For each tuple r in the build input R
    1.1 Add r to the in-memory hash table
    1.2 If the size of the hash table equals the maximum in-memory size:
        1.2.1 Scan the probe input S, and add matching join tuples to the output relation
        1.2.2 Reset the hash table, and continue scanning the build input R
2. Do a final scan of the probe input S and add the resulting join tuples to the output relation

Example

Input:

    @player_ages = (
        [20, "Alex"  ],
        [28, "Joe"   ],
        [38, "Mike"  ],
        [18, "Alex"  ],
        [25, "David" ],
        [18, "Simon" ],
    );

    @player_names = (
        ["Alex", "Stewart"],
        ["Joe",  "Root"   ],
        ["Mike", "Gatting"],
        ["Joe",  "Blog"   ],
        ["Alex", "Jones"  ],
        ["Simon","Duane"  ],
    );

Output:

    Based on index = 1 of @players_age and index = 0 of @players_name.


    20, "Alex",  "Stewart"
    20, "Alex",  "Jones"
    18, "Alex",  "Stewart"
    18, "Alex",  "Jones"
    28, "Joe",   "Root"  
    28, "Joe",   "Blog"
    38, "Mike",  "Gatting"
    18, "Simon", "Duane"

=cut

my @player_ages = ( [20, "Alex"  ], [28, "Joe"   ], [38, "Mike"  ],
                    [18, "Alex"  ], [25, "David" ], [18, "Simon" ], );

my @player_names = ( ["Alex", "Stewart"], ["Joe",  "Root"], ["Mike", "Gatting"],
                     ["Joe",  "Blog"   ], ["Alex", "Jones"],["Simon","Duane"  ],);


sub hash_join
{
     my ( $tbl_1, $idx_1, $tbl_2, $idx_2 ) = @_;
     my %seen;
     my @groups = grep { not $seen{$_}++ } map { $_->[$idx_1] }  @{$tbl_1};
     
     my @output;


     for my $name ( @groups )
     {
          my @slice = grep { $_->[$idx_1] eq $name } @{$tbl_1};

          for my $probe ( grep { $_->[$idx_2] eq $name } @{$tbl_2} )
          {
               for my $item ( @slice )
               {

                    push @output, [@$item, $probe->[1]];
               }
          }
     }

     return @output;
}



my @result = hash_join(\@player_ages, 1, \@player_names, 0);
print join(',', @$_), $/ for @result;