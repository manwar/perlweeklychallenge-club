use strict;
use warnings;

my $str1 = "abc";
my $str2 = "acb";
if (isScrambled($str1,$str2)) { print "true\n"; } else { print "false\n"; }

$str1 = "abcd";
$str2 = "cdba";
if (isScrambled($str1,$str2)) { print "true\n"; } else { print "false\n"; }

$str1 = "hello";
$str2 = "hiiii";
if (isScrambled($str1,$str2)) { print "true\n"; } else { print "false\n"; }

$str1 = "ateer";
$str2 = "eater";
if (isScrambled($str1,$str2)) { print "true\n"; } else { print "false\n"; }

$str1 = "abcd";
$str2 = "bdac";
if (isScrambled($str1,$str2)) { print "true\n"; } else { print "false\n"; }


sub isScrambled {
    my $str1 = $_[0];
    my $str2 = $_[1];
    my @list = scramble ($str1);  #make a list of all possible scrambles of $str1
    #print "@list\n";
    foreach my $str (@list) {     #Iterate over the list
        if ($str eq $str2) {      #Print and return if there is a match
            print "$str2 is a scramble of $str1\n";
            return 1 ;
        }
    }
    print "$str2 is NOT a scramble of $str1\n";
    return 0;
}

sub scramble {                                      #Recursive sub to scramble
    my $s1 = $_[0];
    return $s1 if (length($s1) == 1) ;              #Return immediately if only one letter
    my @scrambles;                                  
    push @scrambles,$s1;                            #First scramble is the string itself
    for (my $sp = 1; $sp < (length($s1)); $sp++) {  #Loop over each split point
        my $ss1 = substr($s1,0,$sp);                #left half of split
        my $ss2 = substr($s1,$sp);                  #right half of split
        my @ss1 = scramble($ss1);                   #scramble left half
        my @ss2 = scramble($ss2);                   #scramble right half
        for my $tss1 (@ss1) {                       #iterate over left half scrambles
            for my $tss2 (@ss2) {                   #iterate over right half scrambles
                push @scrambles, $tss2.$tss1 ;      #add left half cat right half
                push @scrambles, $tss1.$tss2 ;      #add right half cat left half
            }
        }
    }
    return uniq(@scrambles);                        #return list of scrambles without duplicates
}

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}
    
 

