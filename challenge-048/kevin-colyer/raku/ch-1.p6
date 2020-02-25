#!perl6 
# Task 1 Challenge 048 Solution by 
# 
# Survivor
# 
# There are 50 people standing in a circle in position 1 to 50. The person 
# standing at position 1 has a sword. He kills the next person i.e. standing 
# at position 2 and pass on the sword to the immediate next i.e. person standing 
# at position 3. Now the person at position 3 does the same and it goes on 
# until only one survives.
# 
# Write a script to find out the survivor.
# 

# fill the circle with 50 alive people = 1's
my @circle = 1 xx 50;

# helper function to loop around the circle looking for the next living person
sub nextAlive($i) {
    my $j=$i;
    loop {
        # choose next person
        $j++;
        # loop back if reached end of array
        $j=0 if $j>= @circle.elems;
        # return index if that person is living...
        return $j if @circle[$j]==1;
        # prevent infinite loop check
        die "No-one alive in circle" if $i==$j;
        # and loop
    }
}

my $i=0;
my $j=-1;
say "1 has the sword...";

loop {
    # choose victim
    $j=nextAlive($i);
    
    # kill them
    @circle[$j]=0;
    say "{$i+1} killed {$j+1}";
    
    # pass the sword on
    my $k=nextAlive($j);
    
    # check exit the loop if we have just passed sword to ourselves - we are the only living one left
    last if $i == $k;
    
    # pass the sword on
    $i=$k;
    say " and gave sword to {$i+1}";
    # and loop
}

say "So the survivor is {$i+1}";
