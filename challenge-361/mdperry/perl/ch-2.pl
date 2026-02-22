#!/usr/bin/env perl

use v5.38;

# Each example is a community of people; some people know (or have heard of) other people, and some
# people are known by other people.  This data structure codes all of those relationships.
# Just because I know you, does not mean that you also know me.  The attribute of knowing is
# one-way, or assymetric.
# The challenge is to identify if a community contains a person with a specific pattern
# of such connections.  
my @communities = ( [[0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0],],
                    [[0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1], [1, 0, 0, 0]],
                    [[0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 0, 0, 0, 0]],
                    [[0, 1, 0, 1, 0, 1], [1, 0, 1, 1, 0, 0], [0, 0, 0, 1, 1, 0], [0, 0, 0, 0, 0, 0], [0, 1, 0, 1, 0, 0], [1, 0, 1, 1, 0, 0]],
                    [[0, 1, 1, 0], [1, 0, 1, 0], [0, 0, 0, 0], [0, 0, 0, 0]], 
                    [[0, 0, 1, 1], [1, 0, 0, 0], [1, 1, 0, 1], [1, 1, 0, 0]]
                  );

my $example = 1;

foreach my $community ( @communities ) {
    my @people = $community->@*;

    # In some communities there are no people who do not know anyone
    # In other communities there are more than 1 person who do not know anyone
    # We are going to keep track of the number of people in this community who
    # do not know anyone else
    my $celeb = 0;

    # If we find someone who knows nobody else, then we are going to
    # store their name
    my $knows_nobody = 'no candidate';

    # A person's name is the index of their element in the @people array
    # So the first person we evaluate is always named zero, then the names
    # autoincrements
    my $name = 0;

    # In parallel, we are also going to explicitly keep track of who each person
    # is known by (a count)
    my %known_by = ();
    my $community_size = q{};
    
    foreach my $person ( @people ) {
        # The @connections array is analogous to a bit vector that stores whether or not
	# This $person "knows" any of the other people in this community
        my @connections = $person->@*;

	# The number of people a person knows will be the sum of the
	# positions that contain a '1'
        my $count = scalar( grep { $_ > 0 } @connections );

	# If we find a person who doesn't know anybody else, then they are a
	# candidate to be celebrity in this community
        if ( $count == 0 ) {
	    # So we store their name (this value might get clobbered)
	    $knows_nobody = $name;    
            # And we keep a count of the total number of celebrity candidates in this community
            $celeb++;
        }	

	$community_size = scalar( @connections );

	# The celebrity will be known by all of the other people in
	# this community, or: the community_size - 1
	# Here, we use each person's name to store the total
	# number of different people who know them
	foreach my $people (0..$#people) {
            if ( $connections[$people] > 0 ) {
	        $known_by{$name}++;
	    }
        }
        $name++;
    }
    print "Example $example\n";

    # The only way to determine if there is a celebrity is if everyone else knows them
    # and the celebrity doesn't know anyone else.  A community can only have one celebrity
    if ( $celeb != 1 ) {
        print "Output: -1; no celebrity candidates in this Example community\n\n";
    }
    else {
        if ( $known_by{$knows_nobody} = $community_size -1 ) {
            print "Output: $knows_nobody is a celebrity in this Example!\n\n";
	}
        else {
            print "Output: -1; it turns out celebrity candidate is not actually known by everyone else\n\n";
	}
    }
    $example++;
}

exit;

