#!/usr/bin/env perl
# Perl weekly challenge 212
# Task 2:  Rearrange Groups
#
# See https://wlmb.github.io/2023/04/10/PWC212/#task-2-rearrange-groups
use v5.36;

die <<~"FIN" unless @ARGV;
    Usage: $0 S N1 [N2...]
    to split the set N1 N2... into consecutive groups of size S
    FIN

my $size=shift;
my @ordered=sort {$a <=> $b} @ARGV;
my @groups;
my $success=1;
while(@ordered){
    my $group=next_group();
    $success=0, last unless defined $group;
    push @groups, $group;
}
say "Input: @ARGV, size: $size";
say "Output: -1" unless $success;
say "Output: (", join(")(", map {join ", ", @$_} @groups), ")" if $success;

sub next_group(){
    my @group;
    my @repeated;
    while(@ordered && @group < $size){
	my $x=shift @ordered;
	push(@repeated, $x), next if @group and $group[-1]==$x;
	return if @group and $group[-1]+1 != $x;
	push @group, $x;
    }
    @ordered=(@repeated, @ordered);
    return [@group] if @group==$size;
    return;
}
