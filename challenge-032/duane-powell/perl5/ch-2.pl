#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );

# Write a function that takes a hashref where the keys are labels and the values are integer or floating point values. Generate a bar graph of the data and display it to stdout.
# If you fancy then please try this as well: (a) the function could let you specify whether the chart should be ordered by (1) the labels, or (2) the values

use constant {
	BLOCK => '####',
};

my $by_label = shift;

# Eval the data ref saved out by ch-1.pl back into memory
my $data_file = 'ch-1.data.out';
my $e;
if ( open( my $fh, $data_file ) ) {
	$e .= $_ while (<$fh>);
	close($fh);
} else { 
	die "Can not find '$data_file' $!";
}
my $data = eval $e;

generate_bar_graph($data);

sub generate_bar_graph {
	# find longest word and define $format for sprintf
	my $longest = 0;
        foreach (keys %{$_[0]}) {
		my $l = length($_);
		$longest = $l if ($l > $longest);
	}
	my $format = "%-$longest"."s";  

	# sort and print lines
	if ($by_label) {
		# sort by key 
		generate_bar($_[0],$_,$format) foreach (sort {lc($a) cmp lc($b)}           (keys %{$_[0]}));
	} else {
		# sort by value
		generate_bar($_[0],$_,$format) foreach (sort {$_[0]->{$a} <=> $_[0]->{$b}} (keys %{$_[0]}));
	}
}

sub generate_bar {
	my $word = sprintf "$_[2]", $_[1];
	my $bar  = BLOCK x $_[0]->{$_[1]}; 
	say "$word | $bar";
}

__END__

./ch-2.pl
banana   | ########
kumquat  | ########
tomato   | ########
cherry   | ################
plum     | ################
apple    | ########################
Broccoli | ################################################
celery   | ########################################################
zucchini | ################################################################

./ch-2.pl 1                                                                                                                                                                                                                                  apple    | ########################
banana   | ########
Broccoli | ################################################
celery   | ########################################################
cherry   | ################
kumquat  | ########
plum     | ################
tomato   | ########
zucchini | ################################################################

