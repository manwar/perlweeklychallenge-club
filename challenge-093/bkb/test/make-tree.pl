#!/home/ben/software/install/bin/perl

# Make like a tree and blow.

use warnings;
use strict;
use utf8;
use FindBin '$Bin';
use JSON::Create 'create_json';

my $avd = 3;
my $min = 1;
my $max = 5;
my $prob = 1/$avd;
print create_json (node (0), indent => 1, sort => 1);
exit;

sub node
{
    my ($depth) = @_;
    if (($depth > $min && rand () < $prob) || $depth >= $max) {
	return number ();
    }
    my %node;
    $node{l} = node ($depth + 1);
    $node{r} = node ($depth + 1);
    $node{n} = number ();
    return \%node;
}

sub number
{
    return int (rand (10));
}    
    
