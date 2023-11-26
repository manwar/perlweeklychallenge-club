use v5.38;
##
# Given two strings $source and $target write a script to find out if
# using the characters (only once) from source a target string can be
# created.
##
use boolean;
sub special_notes{
    my($source, $target) = @_;
    return special_notes_r([split //, $source], $target);  
}

sub special_notes_r{
    my($source, $target) = @_;
    return true if $target eq q//;
    return false if $target ne q// && @{$source} == 0;
    my $c = pop @{$source}; 
    $target =~ s/$c//;
    return special_notes_r($source, $target);  
}

MAIN:{
    say special_notes q/abc/, q/xyz/;   
    say special_notes q/scriptinglanguage/, q/perl/;   
    say special_notes q/aabbcc/, q/abc/;   
}
