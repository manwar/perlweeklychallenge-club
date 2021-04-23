use strict;
use warnings;
##
# You are given a $name.
# Write a script to display the lyrics to 
# the Shirley Ellis song The Name Game.
##

sub name_game{
    my($name) = @_;
    my($b, $f, $m); 
    my $first_letter = lc(substr($name, 0, 1));
    my $irregular_v = $first_letter =~ tr/aeiou//d;
    my $irregular_bfm = $first_letter =~ tr/bfm//d;
    unless($irregular_v || $irregular_bfm){
        $b = "b" . lc(substr($name, 1)); 
        $f = "f" . lc(substr($name, 1)); 
        $m = "m" . lc(substr($name, 1)); 
    }   
    elsif($irregular_v){
        $b = "b" . lc($name);
        $f = "f" . lc($name); 
        $m = "m" . lc($name); 
    }
    elsif($irregular_bfm){
        $b = "b" . lc(substr($name, 1)); 
        $f = "f" . lc(substr($name, 1)); 
        $m = "m" . lc(substr($name, 1)); 
        $b = lc(substr($name, 1)) if lc(substr($name, 0, 1)) eq "b"; 
        $f = lc(substr($name, 1)) if lc(substr($name, 0, 1)) eq "f"; 
        $m = lc(substr($name, 1)) if lc(substr($name, 0, 1)) eq "m"; 
    }  
    format NAME_GAME = 
        @*, @*, bo-@* 
        $name, $name, $b 
        Banana-fana fo-@* 
        $f 
        Fee-fi-mo-@*
        $m
        @*!
        $name
.
    
    select(STDOUT);
    $~ = "NAME_GAME";
    write();  
}


MAIN:{
    my($name);
    $name = "Katie";  
    name_game($name); 
    print "\n"; 
    $name = "Adam";  
    name_game($name); 
    print "\n"; 
    $name = "Mary";  
    name_game($name); 
}
