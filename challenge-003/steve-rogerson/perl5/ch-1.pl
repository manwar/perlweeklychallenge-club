#!/usr/bin/env perl
use strict;
use warnings;
use List::Util 'min';
use Const::Fast;
use 5.010;

 
sub hamming {
    my ($arg) = @_;
    $arg ||= 0; # pass 1 to restart.
    state  %s;
    if (! %s or  $arg ==1 ) {
        %s = (1=>1); # 1 is the first hamming number.
    }
    my $next = min (keys %s); 
    delete $s{$next};
    for (2,3,5) {
        $s{$next * $_} = 1;
    }
    return $next;
}
 
my $i =0;
++$i, print hamming(), " " until $i > 20;
print "...\n";
 
++$i, hamming() until $i == 1690;
print ++$i, "-th: ", hamming(), "\n";
