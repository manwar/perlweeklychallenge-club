use strict;
use warnings;
##
#  
##


sub equilibrium_index{
    for my $i (0 .. @_ - 1){
        return $i if unpack("%32I*", pack("I*",  @_[0 .. $i])) == unpack("%32I*", pack("I*",  @_[$i .. @_ - 1]));
    }
    return -1;
}

MAIN:{
    print equilibrium_index(1, 3, 5, 7, 9) . "\n";
    print equilibrium_index(1, 2, 3, 4, 5) . "\n";
    print equilibrium_index(2, 4, 2) . "\n";
}