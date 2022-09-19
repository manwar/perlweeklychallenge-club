use v5.36;
use strict;
use warnings;
##
# Given a list of absolute Linux file paths, determine the 
# deepest path to the directory that contains all of them.
##
sub deepest_path{
    my(@paths) = @_;
    my @sub_paths = map { [split(/\//, $_)] } @paths; 
    my @path_lengths_sorted = sort { $a <=> $b } map { 0 + @{$_} } @sub_paths;    
    my $deepest_path = q//; 
    for my $i (0 .. $path_lengths_sorted[0] - 1){
        my @column =  map { $_->[$i] } @sub_paths;
        my %h;
        map { $h{$_} = undef } @column;
        $deepest_path .= (keys %h)[0] . q#/# if 1 == keys %h;  
    }   
    chop $deepest_path;
    return $deepest_path;  
}

MAIN:{
    my $data = do{
        local $/;
        <DATA>; 
    };
    my @paths = split(/\n/, $data);  
    print deepest_path(@paths) . "\n"; 
}

__DATA__
/a/b/c/1/x.pl
/a/b/c/d/e/2/x.pl
/a/b/c/d/3/x.pl
/a/b/c/4/x.pl
/a/b/c/d/5/x.pl
