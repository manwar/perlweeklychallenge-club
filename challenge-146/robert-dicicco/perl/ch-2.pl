#!perl.exe

use strict;
use warnings;
use 5.30.0;

### AUTHOR: Robert DiCicco
### DATE:   05-JAN-2022
### Challenge #145 Curious Fraction Tree

my $pval = '';
my $gpar = '';
my $argc = scalar(@ARGV);

die "Requires one fraction argument!\n" if($argc != 1);

# hash contains fraction and its parent, top is designated by '0'
my %family = (
    '0'   => '0',
    '1/1' => '0',
    '1/2' => '1/1',
    '2/1' => '1/1',
    '1/3' => '1/2',
    '3/2' => '1/2',
    '2/3' => '2/1',
    '3/1' => '2/1',
    '1/4' => '1/3',
    '4/3' => '1/3',
    '3/5' => '3/2',
    '5/2' => '3/2',
    '2/5' => '2/3',
    '5/3' => '2/3',
    '3/4' => '3/1',
    '4/1' => '3/1',
);

if(exists($family{$ARGV[0]})){
    $pval = $family{$ARGV[0]};
    if(exists($family{$pval})){
        $gpar = $family{$pval};
        print("parent = $pval and grandparent = $gpar\n");
    }
} else {
    print("$ARGV[0] not found!\n");
}
