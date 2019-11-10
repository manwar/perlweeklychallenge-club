use strict;
use warnings;
##
# Create a script that accepts one or more files 
# specified on the command-line and count the 
# number of times letters appeared in the files.
##
MAIN:{
    my %letter_count; 
    while(<>){
        chomp;
        my @characters = split(//, $_);
        for my $c (@characters){
            $letter_count{$c}++ if $c=~m/[[:alpha:]]/; 
        } 
    } 
    for my $key (sort keys %letter_count){
        print "$key: $letter_count{$key}\n";
    }  
} 
