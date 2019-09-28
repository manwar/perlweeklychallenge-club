# Write a script that allows you to capture/display historical data. It could be an object or a scalar. For example
# my $x = 10; $x = 20; $x -= 5;
# After the above operations, it should list $x historical value in order.

use strict;
use warnings;
use v5.10;

package hist; 

sub TIESCALAR { 
    my $class = shift;
    my $this = [];
    bless $this, $class;
    return $this;
}

sub STORE { 
    push @{ $_[0] }, $_[1];
} 
sub FETCH { 
    return $_[0][-1];
} 

sub GETHIST {
    return @{ $_[0] };
}
1;

package main; 
use Data::Dumper;

my $obj = tie my $x, "hist"; 

$x = 10; 
$x = 20; 
$x -= 5;
$x = 3.1416;
$x = [qw(a quick brown fox jumps over the lazy dog)];
$x = 1e3;
$x*= sqrt 3;

print Dumper($obj->GETHIST());

