#!/usr/bin/perl
use strict;
use Term::Prompt;
use feature qw( say );
use Data::Dumper;

####  Write a script to demonstrate LRU Cache feature. It should support operations 
####  get and set. Accept the capacity of the LRU Cache as command line argument.
####  Solution by ianrifkin

####  Notes: At first I was trying to have a %lru_map 
####  not contain contents by refs to content, but I'm not sure why
####  And the 'next' and 'prev' were orginally hash refs but I got confused
####  how to delete from the cache

####  Originally was going to organize code better using subs but alas
####  here we are!

### Globals
my $max_cap = $ARGV[0];
die("Input must be a positive number") unless $max_cap > 0;
my @lru_cache = [];
my %lru_map = {};
my $head = undef;
my $tail = undef;

say "Welcome to the LRU Cache.";

while(1) {
    my $action = &prompt('x', "Choose: [get,set,quit]",'');

    if ($action eq 'get') {
	my $item_key = &prompt('x', "Input item key to get", '');
	if (defined $lru_map{$item_key}) {
	    say "Data from cache for key $item_key:";
	    say $lru_map{$item_key}{'data'};
	    $lru_map{$head}{'prev'} = $item_key; #set outgoing first item's prev to new first item
	    $lru_map{$item_key}{'next'} = $head; #set new item's 'next' to outgoing head
	    $head = $item_key; #Update head to current item key
	    $lru_map{$item_key}{'prev'} = undef; #no prev since first in cache	    

	    if ($tail eq $head) { #if the new head was the old tail
		$tail = $lru_map{$tail}{'next'}; #set tail to new last item
	    }
	}
	else {
	    say "Item $item_key not currently in cache. Maybe you want to set it?";
	}

    }
    elsif ($action eq 'set') {
	my $item_key = &prompt('x', "Input key of new item to add to the cache", '');
	my $item_data = &prompt('x', "Input item to add to cache", '');

	$lru_map{$item_key} = {};
	if ($head) { 
	    $lru_map{$head}{'prev'} = $item_key; #set outgoing head's prev to current item
	    $lru_map{$item_key}{'next'} = $head; #set new item's 'next' to outgoing head
	}

	$head = $item_key; #set new item as head
	$tail = $item_key unless $tail; #set tail if no tail yet AKA 1st in cache

	my $size = keys %lru_map; 
	$size--; #don't count item being currently added
	if ($size > $max_cap) { #if this new item can't fit in cache
	    $tail = $lru_map{$tail}{'prev'}; #set new tail
	    delete $lru_map{$lru_map{$tail}{'next'}}; #delete last item in cache
	    delete $lru_map{$tail}{'next'}; #delete new last item's next since it's now last
	}

	$lru_map{$item_key}{'data'} = $item_data; #load actual cache
	$lru_map{$item_key}{'prev'} = undef; #no prev since first in cache

	next;
    }
    elsif ($action eq 'quit') {
	say "Action is $action";
	die("Thank you for trying the LRU Cache!");
    }
    else {
	say "Invalid option selected. Please try again.";
	next;
    }
}
