#!/usr/bin/env perl
# Perl weekly challenge 124
# Task 2: Tug of war
#
# See https://wlmb.github.io/2021/08/02/PWC124/#task-2-tug-of-war
use strict;
use warnings;
use v5.12;
use List::Util qw(sum0 first);
use POSIX qw(floor);

die 'Usage: ./ch-2.pl n1 n2 n3... to balance a set of numbers' unless @ARGV;
my $N=my @set=sort {$a<=>$b} @ARGV;
my $N2=floor $N/2;

my $combinator=combinator($N, $N2);
my $best;
while(my @combination=$combinator->()){
    my @set1=map {$set[$_]} grep {$combination[$_]} 0..$N-1;
    my @set2=map {$set[$_]} grep {!$combination[$_]} 0..$N-1;
    my ($sum1, $sum2)=map {sum0 @$_} \@set1, \@set2;
    my $dif=abs($sum2-$sum1);
    $best={dif=>$dif,set1=>\@set1,set2=>\@set2} unless defined $best && $best->{dif}<=$dif;
}
say "Input: ", join " ", @set;
say "Set1: ", join " ", sort@{$best->{set1}};
say "Set2: ", join " ", @{$best->{set2}};
say "Diff: ", $best->{dif};

sub combinator { # produces combinations of n taken k at a time
    my ($n,$k)=@_;
    my @number=((1) x $k, (0) x ($n-$k)); # binary $n-bit number as array
    my $done=0;
    my $iter=0;
    sub {
	return if $done;
	return @number if $iter++==0; #first time through
	@number=following(@number);
	return @number if @number;
	$done=1;
	return;
    }
}

sub following {
    my @number=@_;
    my $first_10=first {$number[$_]==1 && $number[$_+1]==0} (0..@number-2);
    return unless defined $first_10;
    @number[$first_10, $first_10+1]=(0,1);
    restart (@number[0..$first_10-1]);
    return @number;
}

sub restart {
    return unless @_;
    my $ones=sum0 @_;
    @_[0..$ones-1]=(1)x$ones;
    @_[$ones..@_-1]=(0)x(@_-$ones);
}
