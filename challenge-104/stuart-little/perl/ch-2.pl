#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <nr tokens; defaults to 12>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub youPlay($heap,$k){
    $heap==0 && do {
	say "You lose!";
	exit;
    };
    say "The heap contains $heap tokens.";
    print "How many tokens are you removing? Please enter an integer between 1 and $k inclusive: ";
    my $take = <STDIN>;
    chomp($take);
    compPlay($heap-$take,$k);
}

sub compPlay($heap,$k) {
    $heap==0 && do {
	say "You win!";
	exit;
    };
    say "The heap contains $heap tokens.";
    my $take = ($heap % ($k+1)) || [1..$k]->[rand $k];
    say "The computer removes $take items.";
    youPlay($heap-$take,$k);
}

my $heap = (scalar @ARGV) ? ($ARGV[0]) : (12);
youPlay($heap,3);
