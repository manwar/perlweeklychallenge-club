use strict;
use warnings;
##
# Show multiple arrays content.
##
use Readonly;
Readonly::Array my @A => qw/I L O V E Y O U/;
Readonly::Array my @B => qw/2 4 0 3 2 0 1 9/;
Readonly::Array my @C => qw/! ? £ $ % ^ & */;

sub display{
    my($arrays) = @_; 
    my $max_index = (sort {$a <=> $b} map {scalar @{$_}} @{$arrays})[-1] - 1; 
    for my $x (0 .. $max_index){
        for my $a (@{$arrays}){
            print $a->[$x] // "";
            print "\t";
        }
        print "\n";   
    } 
} 

MAIN:{
    display([\@A, \@B, \@C]);  
} 
 
