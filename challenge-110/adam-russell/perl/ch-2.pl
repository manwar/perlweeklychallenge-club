use strict;
use warnings;
##
# You are given a text file.
# Write a script to transpose the contents of the given file.
##
sub transpose{
    my @columns = @_;
    return transpose_r([], \@columns);  
}

sub transpose_r{
    my($transposed, $remaining) = @_;
    return $transposed if(@{$remaining} == 0);   
    $transposed = transpose_row_r($transposed, $remaining->[0]);  
    shift @{$remaining}; 
    transpose_r($transposed, $remaining);  
}

sub transpose_row_r{
    my($transposed, $row) = @_;
    return $transposed if(@{$row} == 0); 
    my $index = @{$row} - 1;
    push @{$transposed->[$index]}, pop @{$row};  
    transpose_row_r($transposed, $row);    
}

MAIN:{
    my @columns;
    while(my $line = <DATA>){
        chomp($line);
        my @fields = split(/,/, $line);   
        push @columns, \@fields; 
    }
    my $transposed = transpose(@columns);   
    for my $i (0 .. @{$transposed} - 1){
        print join(",", @{$transposed->[$i]}) . "\n";       
    }    
}



__DATA__
name,age,sex
Mohammad,45,m
Joe,20,m
Julie,35,f
Cristina,10,f
