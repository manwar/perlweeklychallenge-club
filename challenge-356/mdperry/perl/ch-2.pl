#!/usr/bin/env perl


# https://theweeklychallenge.org/blog/perl-weekly-challenge-356/#TASK2

use strict;
use warnings;

my @inputs = ( "HAHAHH", "HHHHHH", "HHHAHA", "HAHAAH", "HAAHAA", );

foreach my $input (@inputs) {

    # There are seven teams playing six games over three weeks
    # This data structure will eventually hold all of the information
    # about which of the seven teams were playing at home or away for each
    # game, and which team won.  Hash keys are the numbers of the
    # six games.  In the hashrefs the 'W' hash key will hold the number
    # of the team that won
    my %results = ( '1' => { H => 2,
			     A => 7,
			     W => undef,
			   },
                    '2' => { H => 3,
			     A => 6,
			     W => undef,
		           },
                    '3' => { H => 4,
			     A => 5,
			     W => undef,
			    },
                    '4' => { H => 1,
			     A => undef,
			     W => undef,
			   },
                    '5' => { H => undef,
			     A => undef,
			     W => undef,
			   },
		    '6' => { H => undef,
			     A => undef,
			     W => undef,
		           },
               );

    my @pattern = split(//, $input);

    # Process the results from the first three games played during Week 1
    for my $i (0..2) {						
	$results{$i+1}{W} = $pattern[$i] eq 'H' ? $results{$i+1}{H} : $results{$i+1}{A};
    }

    # Sort the three winning teams from Week 1 based on their original seeds
    my @winners = sort ( $results{1}{W}, $results{2}{W}, $results{3}{W} );

    # Populate the hashrefs for the two games played in Week 2
    $results{4}{A} = $winners[2];
    $results{5}{H} = $winners[0];
    $results{5}{A} = $winners[1];

    # Process the results from the second two games played during Week 2
    for my $i (3,4) {						
        $results{$i+1}{W} = $pattern[$i] eq 'H' ? $results{$i+1}{H} : $results{$i+1}{A};
    }

    # Sort the two winning teams from Week 2 based on their original seeds
    @winners = sort ( $results{4}{W}, $results{5}{W}, );

    # Populate the hashref for game 6 played during Week 3
    $results{6}{H} = $winners[0];
    $results{6}{A} = $winners[1];	
    $results{6}{W} = $pattern[5] eq 'H' ? $results{6}{H} : $results{6}{A};

    # Figure out the numbers of the winning and losing teams
    # from Week 3
    my $champ = $results{6}{W};
    my $loser = q{};

    if ( $results{6}{H} == $champ ) {
        $loser = $results{6}{A};
    }
    else {
        $loser = $results{6}{H};
    }

    print "Output: \"Team $champ defeated Team $loser\"\n";

} # close outer foreach loop

