use strict;
use warnings;
##
#  
##
sub is_represented{
    my($n, $d) = @_;  
    my @contains = grep { grep { $_ == $d } split(//) } (1 .. $n);    
    return $n == unpack("%32C*", pack("C*",  @contains));
}

MAIN:{
    print is_represented(25, 7) + 0 . "\n";  
    print is_represented(24, 7) + 0 . "\n";  
}
