#!/usr/bin/env perl6

my @paths   = "/a/b/c/d", "/a/b/cd", "/a/b/cc", "/a/b/c/d/e";   # Paths to be tested for commonality
my $M       = @paths[0] ~~ / ( .+? \/ )+ /;                     # Split the 1st path in directories
my $common  = "<no common path>";                               # Variable holding verified common path

for 0..$M[0].elems-1 -> $i {                                    #  Test progressively longer portions of first path
    my $cc = [~] $M[0][0..$i];                                  #+ for presence in other paths.
    if commdir($cc) { $common = $cc } else { last };            #  Update verified path on positive verification
}
say $common;                                                    # Output final verified common path


sub commdir ( $cc )                                             #  Test for the presence of a given commonality
{                                                               #+ candidate extracted from the first path in the
    for 1..(@paths.elems-1) -> $j {                             #+ other paths.
        return False if @paths[$j] !~~ /^ $cc /;
    }
    return True;
}
