use strict;
use warnings;
##
# Create a script that accepts two strings, let us call it them "stones" and "jewels".
# It should print the count of the "alphabet" from "stones" found in "jewels". 
##

sub contains_remove{
    my($c) = @_;  
    return sub{
        my($word) = @_;  
        $word =~ s/$c//; 
        return $word;     
    }  
} 

sub make_checks{
    my($word) = @_;
    my @letters = split(//, $word);  
    my @checks;
    for my $c (@letters){
        push @checks, contains_remove($c);  
    } 
    return @checks; 
}

sub check_jewels{
    my($jewels, $checks) = @_;
    my $count = 0; 
    while(@{$checks}){   
        my $check = pop @{$checks};
        my $c = $check->($jewels);
        $count += (length($jewels) - length($c));
    }
    return $count;  
}  

MAIN:{
    my($stones, $jewels) = ($ARGV[0], $ARGV[1]);
    chomp($stones);
    chomp($jewels);
    my @checks = make_checks($stones); 
    print check_jewels($jewels, \@checks) . "\n"; 
}   
