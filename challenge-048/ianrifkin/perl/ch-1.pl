#!/usr/bin/perl
use strict;

# There are 50 people standing in a circle in position 1 to 50. 
# The person standing at position 1 has a sword. He kills the 
# next person i.e. standing at position 2 and pass on the sword 
# to the immediate next i.e. person standing at position 3. Now 
# the person at position 3 does the same and it goes on until 
# only one survives.

# Solution by ianrifkin

my $num_people = 50;

#create array of people
my @people;
for (1..$num_people) {
    $people[$_] = $_;
}

#give first person a sword
my $curr = shift @people;

while (scalar(@people) > 1) {
    #current person has sword
    #move current person to end
    my $curr = shift @people;
    push @people, $curr;

    #kill next person
    my $curr = shift @people;

    next;
}


print "\n***** The lone survivor is @people *****\n\n";
