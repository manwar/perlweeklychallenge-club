#!/usr/bin/perl
use strict;
use Algorithm::Combinatorics qw/combinations/;
use integer;

# Usage: ch-2.pl N (LIST of N integers)
# e.g. ch-2.pl 4 1 2 3 4
# 4 2 3 1
# 4 1 3 2
# 3 2 4 1
# 3 1 4 2
# 2 1 4 3
#
# BUG!!!: need to fix when   number_of_elements_of_median >= number_of_all_elements/2 
#      for example, input: 1 2 2 2 2 3
#      in those situation, it will repeat some arrays.

my $oN = shift @ARGV;
my @userinput = sort {$a<=>$b} @ARGV;
if (($#userinput + 1) != $oN) {die "The number of terms does not match.";}

my @tempuserin;
my @begin = map {-1} @userinput;
my %bigbag;
my $starter;
my $N = $oN;
my $j;

sub transformer {
    @tempuserin = ($userinput[0]);
    for (1..$#userinput) {
        if ($userinput[$_] != $userinput[$_-1]) {
            push @tempuserin, $userinput[$_]; 
        }
    }

    $j = 1;
    $bigbag{1} = 1;
    for (1..$#userinput) {
        if ($userinput[$_] == $userinput[$_-1]) {
            $bigbag{$j}++; 
        } else {
            $j++;
            $bigbag{$j} = 1;
        }
    }

    @begin = map {-1} @userinput;
    $starter = $j;

    #    print %bigbag, " ";
}

sub reverse_transformer_and_print { #argv: a wave array in canoical form
   
    if ($oN%2 == 0) {pop @_;} 
    #remove the effect of &add_a_largest_ele_to_end

    foreach (@_) {
        print $tempuserin[$_-1], " ";
    }
    print "\n";
}

sub add_a_largest_ele_to_end {  
    #making even number of balls to odd number of balls
    if ($oN%2 == 0) { push @begin, $j+1; $N=$oN+1;}
}




transformer;
add_a_largest_ele_to_end;
place_the_heaviest_balls_of_bag_in_urns(\$starter, \@begin, \%bigbag);



sub place_the_heaviest_balls_of_bag_in_urns {  
    #argv: ref of the common value of those balls, ref of the array, ref of the hash
if (${$_[0]} == 1) {ending(1, $_[1]);} else { 
    my $current = ${$_[0]}; 
    my @a = @{ $_[1] };
    my %hashbag = %{ $_[2] };


    #three consective urns with the same labelled balls

    my @loc_flatHLHurns = ();
    for (my $i=1; $i < $N-1; $i += 2) {
        if ($a[$i] == -1 and $a[$i-1] == -1 and $a[$i+1] == -1) {
            push @loc_flatHLHurns, $i;
        }
    }
    
    my $maxs = min(int( $hashbag{$current} / 3), 1+$#loc_flatHLHurns) ;
    if (scalar @loc_flatHLHurns != 0 and $maxs != 0) {
        for my $bully (1..$maxs) {
            my $flatiter = combinations(\@loc_flatHLHurns, $bully);
            while (my $flatx = $flatiter->next) {
                my @p = @{$flatx};
                my @newa = @a;
                foreach (@p) {
                    $newa[$_] = $current;
                    $newa[$_+1] = $current;
                    $newa[$_-1] = $current;
                }
                my %newhashbag = %hashbag;
                $newhashbag{$current} -= 3 * $bully;
                my $newcurrent = $current;
                place_the_heaviest_balls_of_bag_in_urns(\$newcurrent, \@newa, \%newhashbag);
            }
        }
    }


    #doublet: getstronger    ..(LHL)H**(LHLHLH)..
    my @loc_stronger = ();
    for (my $i=1; $i < $N-1; $i += 2) {
        if ($a[$i] == -1 and $a[$i+1] == -1 and $a[$i-1] > $current) {
            push @loc_stronger, $i;
        }
    }
    my $maxst = min(int( $hashbag{$current} / 2), 1+$#loc_stronger) ;
    if (scalar @loc_stronger != 0 and $maxst != 0) {
        for my $b_st (1..$maxst) {
            my $stronger = combinations(\@loc_stronger, $b_st);
            while (my $b_stx = $stronger->next) {
                my @p = @{$b_stx};
                my @newa = @a;
                foreach (@p) {
                    $newa[$_] = $current;
                    $newa[$_+1] = $current;
                }
                my %newhashbag = %hashbag;
                $newhashbag{$current} -= 2 * $b_st;
                my $newcurrent = $current;
                place_the_heaviest_balls_of_bag_in_urns(\$newcurrent, \@newa, \%newhashbag);
            }
        }
    }


    #doublet: getweaker    ..(LHL)**H(LHLHLH)..
    my @loc_weaker = ();
    for (my $i=2; $i < $N-1; $i += 2) {
        if ($a[$i] == -1 and $a[$i+1] == -1 and $a[$i+2] > $current) {
            push @loc_weaker, $i;
        }
    }

    my $maxwk = min(int( $hashbag{$current} / 2), 1+$#loc_weaker) ;
    if (scalar @loc_weaker != 0 and $maxwk != 0) {
        for my $b_wk (1..$maxwk) {
            my $weaker = combinations(\@loc_weaker, $b_wk);
            while (my $b_wkx = $weaker->next) {
                my @p = @{$b_wkx};
                my @newa = @a;
                foreach (@p) {
                    $newa[$_] = $current;
                    $newa[$_+1] = $current;
                }
                my %newhashbag = %hashbag;
                $newhashbag{$current} -= 2 * $b_wk;
                my $newcurrent = $current;
                place_the_heaviest_balls_of_bag_in_urns(\$newcurrent, \@newa, \%newhashbag);
            }
        }
    }



    #which light urns can be placed the heavy balls?
    for (1..$N-2) {
        if ($_ % 2 == 1 and $a[$_] == -1 and $a[$_+1] > 0 and $a[$_-1] > 0) {
            $a[$_] = 0; 
        }
    }



    my @loc_empty_and_putable_urns = ();       
          #locations of heavy/"eatmoreed" and empty urns
    for (2..$N-3) {                        #original: for (0..$N-1);
        if ( ($_ % 2 == 0 and $a[$_] == -1) or $a[$_] == 0 ) {
            push @loc_empty_and_putable_urns , $_;
        }
    }



    my $lefts  =  (($a[0] <= 0) and ($a[1] <= 0) and ($a[2] > 0));
    my $rights = (($a[-1] <= 0) and ($a[-2] <= 0) and ($a[-3] > 0) and ($N%2==1));

    ########################################


    if ($hashbag{$current} >= 4 and $lefts and $rights and $#loc_empty_and_putable_urns+1 >= $hashbag{$current}-4 ) {
        my $lriter = combinations(\@loc_empty_and_putable_urns, $hashbag{$current}-4);
        while (my $lrx = $lriter->next) {
            my @p = @{$lrx};
            my @newa = @a;
            foreach (@p) {
                $newa[$_] = $current;
            }            
            ($newa[0], $newa[1], $newa[-1], $newa[-2]) = 
                  ($current, $current, $current, $current );
            my $newcurrent = $current-1;
            my %newhashbag = %hashbag;
            place_the_heaviest_balls_of_bag_in_urns(\$newcurrent, \@newa, \%newhashbag);
        }
    }



    ########################################

    if ($hashbag{$current} >= 2 and $lefts and $#loc_empty_and_putable_urns+1 >= $hashbag{$current}-2) {
        my $liter = combinations(\@loc_empty_and_putable_urns, $hashbag{$current}-2);
        while (my $lx = $liter->next) {
            my @p = @{$lx};
            my @newa = @a;
            foreach (@p) {
                $newa[$_] = $current;
            }            
            ($newa[0], $newa[1]) = ($current, $current);
            my $newcurrent = $current-1;
            my %newhashbag = %hashbag;            
            place_the_heaviest_balls_of_bag_in_urns(\$newcurrent, \@newa, \%newhashbag);
        }
    }


    ########################################
    
    if ($hashbag{$current} >= 2 and $rights and $#loc_empty_and_putable_urns+1 >= $hashbag{$current}-2) {
        my $riter = combinations(\@loc_empty_and_putable_urns, $hashbag{$current}-2);
        while (my $rx = $riter->next) {
            my @p = @{$rx};
            my @newa = @a;
            foreach (@p) {
                $newa[$_] = $current;
            }            
            ($newa[-1], $newa[-2]) =  ($current, $current);
            my $newcurrent = $current-1;
            my %newhashbag = %hashbag;
            place_the_heaviest_balls_of_bag_in_urns(\$newcurrent, \@newa, \%newhashbag);
        }
    }


    ########################################


    if ($a[0] == -1) {
        unshift @loc_empty_and_putable_urns, 0;
    }

    if ($a[1] == 0) {
        unshift @loc_empty_and_putable_urns, 1;
    }
    
    if ( ( ( ($N-2)%2 == 0 and $a[$N-2] == -1) or $a[$N-2] == 0 )  )   {
        push @loc_empty_and_putable_urns, $N-2;
    }

    if (( ( ($N-1)%2 == 0 and $a[$N-1] == -1) or $a[$N-1] == 0  ) )  {
        push @loc_empty_and_putable_urns, $N-1;
    }

    my $remainballs = $hashbag{$current} - ($#loc_empty_and_putable_urns+1);
    
    # @loc_empty_and_putable_urns + already occupied --> all heavy urns
    # for loop allow the current  1.. $hashbag - $heavy urns

    if ($remainballs <= 0) {
        my $iter = combinations(\@loc_empty_and_putable_urns, $hashbag{$current}); 
        while (my $x = $iter->next) {
            my @p = @{$x};
            my @newa = @a;            
            foreach (@p) {
                $newa[$_] = $current;
            }
            my $newcurrent = $current-1;
            my %newhashbag = %hashbag;
            place_the_heaviest_balls_of_bag_in_urns(\$newcurrent, \@newa, \%newhashbag);
        }
    }    

}            
}



sub ending {
    my @e = @{$_[1]};
    if ($_[0] == 1) {

       for (0..$N-1) {
           if ( $e[$_] <= 0 ) {$e[$_] = 1;}
       }

       reverse_transformer_and_print @e;
       #finally
       #print join ",", @e, "\n";
    }
}



sub min {
     $_[0] < $_[1] ? return $_[0] : return $_[1] ;
}



