#!/usr/bin/env perl6
use v6;

# run <script> <nr tokens; defaults to 12>

sub youPlay($heap,$k){
    $heap==0 && do {
	say "You lose!";
	exit;
    }
    say "The heap contains $heap tokens.";
    my Int $take = prompt("How many tokens are you removing? Please enter an integer between 1 and $k inclusive: ");
    compPlay($heap-$take,$k);
}

sub compPlay($heap,$k) {
    $heap==0 && do {
	say "You win!";
	exit;
    }
    say "The heap contains $heap tokens.";
    my Int $take = ($heap % ($k+1)) || (1..$k).roll;
    say "The computer removes $take items.";
    youPlay($heap-$take,$k)
}

my $heap = (@*ARGS) ?? (@*ARGS[0].Int) !! (12);
youPlay($heap,3);
