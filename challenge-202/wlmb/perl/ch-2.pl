#!/usr/bin/env perl
# Perl weekly challenge 202
# Task 2:  Widest Valley
#
# See https://wlmb.github.io/2023/01/30/PWC202/#task-2-widest-valley
use v5.36;
use List::UtilsBy qw(max_by);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find the widest valley in the sequence N1 N2...
    FIN

my @in=@ARGV;
my $ascending=0;
my @up=my @down=(my $previous=shift);
my @out;
for(@ARGV){
    if($_>$previous){
	@up=@down unless $ascending;
	@down=();
	$ascending=1;
    }
    if($_<$previous){
	push @out, [@up];
        @up=();
	$ascending=0;
    }
    push @down, $_;
    push @up, $_;
    $previous=$_;
}
push @out, [@down], [@up];
my $result=max_by {@$_} @out;
say join " ", @in, "->", @$result;
