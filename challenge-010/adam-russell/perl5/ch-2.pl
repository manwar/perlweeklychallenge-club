use strict;
use warnings;
##
# Write a script to find Jaro-Winkler distance between two strings.
##
use boolean;    
use constant P => 0.1;  
use constant STRING_A => "cats";  
use constant STRING_B => "rabbits";  
use constant LENGTH_A => length(STRING_A);  
use constant LENGTH_B => length(STRING_B);  
sub max{
    my($a, $b) = @_; 
    return $a > $b ? $a : $b;   
}  
use constant MATCH_DISTANCE => max(LENGTH_A, LENGTH_B) / 2 - 1;  
sub min{
    my($a, $b) = @_; 
    return $a < $b ? $a : $b;   
} 

sub jaro{
    my($a, $b) = @_;  
    my $matches = 0;
    my $transpositions = 0;  
    my @a_matches;  
    my @b_matches;  
    for(my $i = 0; $i < LENGTH_A; $i++){
        my $end = min($i + MATCH_DISTANCE + 1, LENGTH_B);   
        for(my $j = max(0, $i - MATCH_DISTANCE); $j < $end; $j++){
            if(!$b_matches[$j] && $a->[$i] eq $b->[$j]){   
                $a_matches[$i] = true;
                $b_matches[$j] = true;
                $matches++;
                last;   
            }          
        }   
    }  
    if(!$matches){  
        return 0;  
    }  
    my $j = 0;
    for(my $i = 0; $i < LENGTH_A; $i++){  
        if($a_matches[$i]){
            while(!$b_matches[$j]){
                $j++;   
            }  
            if($a->[$i] ne $b->[$j]){  
                $transpositions += 0.5;  
            }   
            $j++;
        }
    }   
    return (($matches / LENGTH_A) + ($matches / LENGTH_B) + (($matches - $transpositions) / $matches)) / 3; 
}  

sub jaro_winkler{
    my($a, $b, $jaro) = @_;
    my $prefix_length = 0;  
    for my $i (0..3){
        if($a->[$i] eq $b->[$i]){
            $prefix_length++;  
        }  
    } 
    my $sim_w = $jaro + (($prefix_length * P)*(1 - $jaro));
    return 1 - $sim_w;     
}  

##
# Main 
##  
my @a = split(//, STRING_A); 
my @b = split(//, STRING_B); 
my $r = sprintf("%1.3f", jaro_winkler(\@a, \@b, jaro(\@a, \@b)));   
print "Jaro-Winkler distance of " . STRING_A . " <-> " . STRING_B . ": $r\n";
