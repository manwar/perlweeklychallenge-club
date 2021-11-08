use strict;
use warnings;
## 
# You are given m x n binary matrix having 0 or 1.
# Write a script to find out maximum sub-matrix having only 0.
##
use Tree::Suffix; 

sub maximum_sub_matrix{
    my @matrix = @_;
    my @sub_matrix;

    my %indices;  
    my @indices_maximum;
    my $indices_previous = "";
    my $indices_current = "";
    my $tree = new Tree::Suffix(); 
    for my $i (0 .. @matrix - 1){
        $indices_current = "";
        for my $j (0 .. @{$matrix[0]} - 1){
            $indices_current .= $j if $matrix[$i][$j] == 0;  
            $indices_current .= "x" if $matrix[$i][$j] == 1;  
        }
        $tree->insert($indices_current);  
        for my $n (2 .. @{$matrix[0]}){
            for my $s ($tree->longest_common_substrings(1, $n)){
                if(!$indices{$s}){
                    $indices{$s} = [$i - 1, $i];  
                }
                else{ 
                    push @{$indices{$s}}, $i - 1, $i; 
                } 
            }
        }
        $tree->remove($indices_previous) if $indices_previous; 
        $indices_previous = $indices_current; 
    } 
    for my $s (keys %indices){
        my $max_area = -1; 
        my @indices = sort {$a <=> $b} do { my %seen; grep { !$seen{$_}++ } @{$indices{$s}} };  
        unless($indices[0] < 0){
            my $area = 0;
            my $count = 0; 
            for(my $i = 0; $i <=  @indices - 1; $i++){ 
                $count++; 
                $area += length($s) if $i == 0;
                $area += length($s) if $i > 0 && $indices[$i] == $indices[$i - 1] + 1;   
                do {$area = 0 ; $count = 0} if $i > 0 && $indices[$i] != $indices[$i - 1] + 1;  
            }
            if($area >= $max_area){
                $max_area = $area; 
                push @indices_maximum, [$s, $count];      
            } 
        } 
    } 
    for (0 .. $indices_maximum[0][1] - 1){
        push @sub_matrix, [(0) x length($indices_maximum[0][0])];  
    }  
    return @sub_matrix; 
}

MAIN:{
    my @sub_matrix = maximum_sub_matrix(
        [1, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0]
    );
    for my $row (@sub_matrix){
        print "[" . join(" ", @{$row}) . "]\n"; 
    }  
} 
