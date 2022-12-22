#!/usr/bin/env -S perl -wl

use strict;
use Data::Dumper qw(Dumper);
use Algorithm::Combinatorics qw(combinations);

print Dumper(&pattern_132([3,1,4,2])); #(1,4,2)
print Dumper(&pattern_132([1,2,3,4])); #""
print Dumper(&pattern_132([1,3,2,4,6,5])); #(1,3,2)
print Dumper(&pattern_132([1,3,4,2])); #(1,3,2)

sub pattern_132 {
    my ($ra_list)=@_;
    
    ( map {@$ra_list[@$_]}
    grep { ( ($$ra_list[$_->[1]]) > ($$ra_list[$_->[2]]) )  }
    grep { ( ($$ra_list[$_->[2]]) > ($$ra_list[$_->[0]]) )  }
    combinations([0 .. @$ra_list-1],3) ) [0 .. 2];
    
}

