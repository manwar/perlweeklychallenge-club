use v5.36;
use strict;
use warnings;
##
# Given a list of absolute Linux file paths, determine the 
# deepest path to the directory that contains all of them.
##
sub deepest_path{
    my(@paths) = @_;
    my @path_lengths_sorted = sort { $a cmp $b } map { length($_) } @paths;
    for my $i (0 .. $path_lengths_sorted[0] - 1){

    }    
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
