#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;
use List::Util qw(sum min);
use feature qw(switch);

#part 2
my %priorityQ = (1 => ['apple','ball']);
insert_with_priority(\%priorityQ,'cat',2);
print pull_highest_priority_element(\%priorityQ),"\n";
print pull_highest_priority_element(\%priorityQ),"\n";
if( is_empty(\%priorityQ) ){
	print "empty\n";
}else{
	print "not empty\n";
}

sub insert_with_priority{
	#(pQ,ele,priority)
	my ($pQ,$val,$key) = @_;
	if( $pQ->{$key} ){					#if key exist
		push( $pQ->{$key},$val );
	}else{
		$pQ->{$key} = [$val] ;			#key doesn't exist
	}
}
sub pull_highest_priority_element{
	#(pQ)
	my ($pQ) = @_;
	my $key =  min keys $pQ;
	my $val = shift( $pQ->{$key} );
	delete $pQ->{$key}  unless @{$pQ->{$key}};
	return $val;
}

sub is_empty{
	#(pQ)
	my ($pQ) = @_;
	return not scalar %{$pQ};
}

print '='x10," P Queue ",'='x10,"\n";
print Dumper \%priorityQ;
