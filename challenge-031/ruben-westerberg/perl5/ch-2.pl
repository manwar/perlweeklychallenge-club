#!/usr/bin/env perl
use feature qw<say>;
my $name=$ARGV[0]// "var".rand;
my $value=$ARGV[1]//rand;

{
	say "Using symbolic refs";
	no strict refs;
	$$name=$value;
	say "Variable name: $name Value: ${$name}";
}
print "\n";
{
	say "Using a hash";
	my %h;
	$h{$name}=$value;
	say "Variable name: $name Value: $h{$name}";
}
