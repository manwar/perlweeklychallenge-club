use strict; use warnings; use List::Util 'any'; use Test::More tests=>5;

sub dcv {
    my %freq;
    $freq{$_}++ for @_;
    not any { $_[$_] != ($freq{$_}//0) } 0 .. $#_;
}

my($true,$false)=(1,'');
is dcv(1,2,1,0) => $true;
is dcv(0,3,0) => $false;
is dcv(2,1,2,0,0) => $true;
is dcv(3,2,1,1,0,0,0) => $true;
is dcv(5,2,1,0,0,1,0,0,0) => $true;
