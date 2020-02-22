#!/usr/env/perl
# Task 1 Challenge 048 Solution by saiftynet
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
# Probably the best way to implement a circular list is to shift an element
# and then push it back on the ther end...s the whole array rotates, and
# our index remain in the same position, rather than to have a pointer
# that is checked to see if it has reached the boundary every time and 
# reset to end or start depending on which way we moving the pointer.
#
# For the purposes of this task, we will have the sword holder at position 0
# the victime is at postion 1, and the sword receiver is at position 2.
#
# For a bit of fun, an attempt is made at animating this.  This works on
# an 80x24 console that supports `cls` in Windows or `clear` in Linux
# or OSX


my @circleList=(1..50);

# clear screen can be done using Term::XXX, but in case the module is
# not accessible, I have adapted an answer from
# https://stackoverflow.com/questions/197933

my $clearScreen=( $^O=~/Win/)?`cls`:`clear`;

my $animate=1;       # set this to 0 if you dont want to animate.
 
while (scalar @circleList >1){
  if ($animate){     # animation is optional; may not work or be desired
	 select(undef, undef, undef, 0.25); 
	 print $clearScreen;
     circle(\@circleList);
  }
  else{
	   print join ",",@circleList;
  }
  my $killer=shift @circleList;    # get the killer, ready to push to end
  my $killed=shift @circleList;    # get the killed and dump it
  push @circleList,$killer;        # push killer to end of list
  print "\n$killer killed $killed".# display results
        ( (scalar @circleList > 1)?
           " and passed sword to $circleList[0]\n":
           " and is last man standing!!\n");
  
}

# subroutine to plot a circular list in a circle. 
sub circle{  
	my $circleList=shift;         
	my @plotArea   = ();          # reset plot area
    push @plotArea, [("  ") x 40,"\n"]
         foreach (0..16);         # two spaces per point
     
    my $center=[9,20];            # adjust for different console sizes
    my $radius=[8,18];            # adjust for different console sizes
     foreach my $angle (0..@$circleList-1){
       $plotArea [$$center[0]+$$radius[0]*sin($angle*6.28/@$circleList)]
                 [$$center[1]-$$radius[1]*cos($angle*6.28/@$circleList)]
                 =$$circleList[$angle];       
     }
         print @{$_} foreach (@plotArea); # the plot area
}
