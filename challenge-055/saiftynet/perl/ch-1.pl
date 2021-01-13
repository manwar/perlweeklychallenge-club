#!/usr/env/perl
# Task 1 Challenge 055 Solution by saiftynet
# Flip Binary
# You are given a binary number B, consisting of N binary digits 
# 0 or 1: s0, s1, …, s(N-1).
# Choose two indices L and R such that 0 ≤ L ≤ R &lt; N and flip 
# the digits s(L), s(L+1), …, s(R). By flipping, we mean change 
# 0 to 1 and vice-versa.

# Flipping selective bits in a binary number can done using a mask to
# differentiate between the bits to be flipped and the bits to be left
# and using this in a binary operation  (~$bin & $mask) | ($bin & ~$mask).
# But this is Perl and flipping strings is also straightforward.
# This solution offers both methods

$bin= "0101001001110";  # a string is used to preserve leading zeros
$verbosity=0;           # setting this to one enables more verbose output

stringFlips($bin, $verbosity);
binFlips   ($bin, $verbosity);

sub stringFlips{
  my ($binString,$verbose)=@_;
  my $maxIndex=(length $binString)-1;
  my @bestFlips=();
  my $maxCount=0;
  for my $l(0..$maxIndex){                 # all possible l
    for my $r ($l..$maxIndex){            # all possible r
        # extract segment
        my $flip=substr($binString,$l,$r-$l+1);
        my $flipped=$binString;
        # flip segment
        $flip=~tr/01/10/;
        # insert flipped portion back
        substr($flipped,$l,$r-$l+1,$flip);
         
        my $count=scalar(()= $flipped=~/1/g);
        if ($count > $maxCount){     # new high score
           @bestFlips=([$l,$r]);      # reset the list of best flips
           $maxCount=$count;
        }
        elsif($count==$maxCount){    # another pair achieves high score
           push @bestFlips, [$l,$r];  # save it among the best
        }
         
        # verbose option for debugging purposes
        printf "L=%2d R=%2d produces %s with %d ones\n",
                   $l,$r,$flipped,$count if $verbose;
	  
    }
  }
  print "Flips using string transformation and substitution method\n";
  print scalar @bestFlips." best Flips generated from flips of '$binString' giving $maxCount ones\n";
  foreach my $lr (@bestFlips){
     print "(L=$$lr[0], R=$$lr[1])\n";
  }	
}

sub binFlips{   
  my ($binString,$verbose)=@_;
  my $maxLength=(length $binString)-1;
  my $maxCount=0;
  my @bestFlips=();
  for my $l (0..$maxLength){                 # all possible l
     for my $r ($l..$maxLength){             # all possible r		 
        # create a mask
        my $maskString=("0"x$l).("1"x($r-$l+1)).("0"x($maxLength-$r));
        
        # selective flipping
        my $result=selectiveFlip($binString,$maskString);
        
        # count the number of ones
        my $count=scalar(()= $result=~/1/g); 
                                            
        if ($count > $maxCount){             # new high score
           @bestFlips=([$l,$r, $maskString]);# reset the list of best flips
           $maxCount=$count;
        }
        elsif($count==$maxCount){            # another pair achieves high score
           push @bestFlips, [$l,$r,$maskString];# save these
        }
        
        # verbose option for debugging purposes
        printf "L=%2d R=%2d gives flip mask %s produces %s with %d ones\n",
                   $l,$r,$maskString,$result,$count if $verbose;
     }
  }
  print "Flips using binary operations method\n";
  print scalar @bestFlips." best Flips generated from flips of '$binString' giving $maxCount ones\n";
  foreach my $lr (@bestFlips){
     print "(L=$$lr[0], R=$$lr[1])\n";
  }
}

sub selectiveFlip{
  my ($binS,$maskS)=@_;
  $bin =oct("0b$binS" );
  $mask=oct("0b$maskS");
  return sprintf ("%0*b",length $binS, (~$bin & $mask) | ($bin & ~$mask));
}


