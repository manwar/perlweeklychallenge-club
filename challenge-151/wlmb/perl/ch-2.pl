#!/usr/bin/env perl
# Perl weekly challenge 151
# Task 2: Rob the house
#
# See https://wlmb.github.io/2022/02/07/PWC151/#task-2-rob-the-house
use v5.12;
use warnings;
die "Usage: ./ch-1.pl V0 [V1]...\n"
    . "to optimize the robery of houses 0, 1,... with valuables V0, V1..."
    unless @ARGV;
my ($value,@houses)=optimize(0,@ARGV);
say "Output: $value Houses: ", join ", ", @houses;
sub optimize {
    my ($this, $value, @rest)=@_;
    return (0) unless defined $value; # No more houses
    return ($value, $this) unless @rest; # Only one house left
    my ($v1, @h1)=optimize($this+1, @rest); # what if I skip this house?
    my ($v2, @h2)=optimize($this+2, @rest[1..@rest-1]); # what if I rob this and skip next?
    my $v3=$value+$v2;
    $v3>$v1 # which option is best?
	?($v3, $this, @h2) # This one and skip next
	:($v1, @h1); # or skip this one
}
