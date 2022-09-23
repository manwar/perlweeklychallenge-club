#!/usr/bin/perl

# Peter Campbell Smith - 2022-09-20
# PWC 183 task 1

use v5.28;
use utf8;
use warnings;

# You are given list of arrayrefs. Write a script to remove the duplicate arrayrefs 
# from the given list.

# Blog: https://pjcs-pwc.blogspot.com/2022/09/unique-arrays-and-differing-dates.html 

my (@lists, @list, $separator, $list_ref, $item, $signature, @new_list, %seen);

# inputs
@lists = (
	[[1,2], [3,4], [5,6], [1,2]], 
	[[9,1], [3,7], [2,5], [2,5]],
	[[4,6], [6,4], [9,0], [6,4], [5,7], [7,-1], [4,6]],
	[['cat', 'dog'], ['cat', 'mouse'], ['cat, cat'], ['dog', 'cat'], ['mouse', 'mouse'], ['cat', 'mouse']],
	[[1, 2], [1.0, 2.0], [1e0, 2e0], ['1', '2'], [4 - 3, 9 - 8], [0, 0]]);

# loop over inputs and initialise
$separator = 0xFF;
while ($list_ref = shift @lists) {
	@list = @$list_ref;
	@new_list = ();
	%seen = ();
	say '';
	
	# loop over items in @list and add them to @new_list if unseen so far
	for $item (@list) {
		$signature = array_signature($item);
		next if $seen{$signature};
		push @new_list, $item;
		$seen{$signature} = 1;
	}

	# show the input and output
	show_list('Input: ', @list);
	show_list('Output:', @new_list);
}

sub array_signature {
	
	# returns a stringified copy of inpout @list
	my ($list, $j, $signature);
	
	$list = shift;
	for $j (0 .. scalar @$list - 1) {
		$signature .= $list->[$j] . $separator;
	}
	return $signature;
}

sub show_list {
	
	# displays @list in Mohammad's format
	my ($caption, @list, $output, $j);
	
	($caption, @list) = @_;
	$output = qq[$caption (];
	for $item (@list) {
		$output .= '[';
		for $j (0 .. scalar @$item - 1) {
			$output .= $item->[$j] . ', '
		}
		$output =~ s|, $|], |;
	}
	$output =~ s|, $|)|;
	say $output;
}
	