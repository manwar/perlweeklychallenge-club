#!/usr/bin/env perl
# Perl weekly challenge 116
# Task 1: Number sequence
#
# See https://wlmb.github.io/2021/06/11/PWC116/#task-1-number-sequence
use strict;
use warnings;
use POSIX qw(ceil);
use v5.12;

my @digits=@ARGV;
die "Usage ./ch-1.pl digits1 [digits2...]" unless @digits;
foreach(@digits){
    warn("Expected >=10"), next unless $_>=10;
    my @sequence=find_sequence($_);
    say "Input: $_";
    say "Output: ", @sequence? join ",", @sequence:$_;
}
sub find_sequence {
    my $digits=shift;
    my $max=ceil length($digits)/2;
    foreach(reverse 1..$max){ #from large to small starting numbers
	my @result=find_sequence_initial_size($digits, $_);
	return @result if @result;
    }
    return;
}
sub find_sequence_initial_size {
    my ($digits, $size)=@_;
    my $first=substr $digits,0,$size,"";
    #Search upwards first and downwards next
    my $result=increasing([$first],[$digits]);
    return @$result if $result;
    return;
}

sub increasing {
    my ($current, $rest)=@_;  # current sequence and remaining fragments
    my $next=$current->[-1]+1; # next number in sequence
    my @next=(@$current, $next); # next sequence if succesful
    my $iterator=try_many($next, @$rest); #find $next number in @rest
    while(my $remaining=$iterator->()){ # match?
         my @remaining=@$remaining;
         return [@next] if @remaining==0; #exhausted digits?
	 my $attempt=increasing([@next], [@$remaining]); # recurse
	 return $attempt if defined $attempt; #finished?
	 $attempt=decreasing([@next],[@$remaining]); #grow in opposite dir.
	 return $attempt if defined $attempt; #success?
    }
    return decreasing($current, $rest); # backtrack and try opposite dir.
}

sub decreasing {
    my ($current, $rest)=@_;  # current sequence and remaining fragments
    my $previous=$current->[0]-1; # previous number in sequence
    return if $previous < 0; # failure. No negatives.
    my @next=($previous, @$current); #next sequence if succesful
    my $iterator=try_many($previous, @$rest);
    while(my $remaining=$iterator->()){ #match?
         my @remaining=@$remaining;
         return [@next] if @remaining==0; #finished
	 my $attempt=decreasing([@next], [@remaining]); #recurse
	 return $attempt if defined $attempt; #success
    }
    return; #failure
}

sub try_many { # returns iterator to search $target within @numbers in all possible ways
    my ($target, @numbers)=@_;
    die "Expected one or more numbers" unless @numbers>=1;
    my $current=0;
    my $iterate=try_one($target, $numbers[$current]);
    sub {
	while($current<@numbers){
	    my @next=$iterate->();
	    #return array of remaining fragments, filtering out empty strings
	    return [grep {$_ ne ""} (@numbers[0..$current-1],@next, @numbers[$current+1..@numbers-1])] if @next;
	    ++$current;
	    $iterate=try_one($target, $numbers[$current]) if $current < @numbers;
	}
	return;
    }
}

sub try_one {
    my ($target, $digits)=@_; # iterator to split target from $digits in all possible ways
    my $length=length $target;
    die "Expect positive length" unless $length > 0;
    my $index=-1; #index of $target in $digits
    sub {
	$index=index $digits, $target, $index+1;
	return unless $index >=0;
	return (substr($digits,0,$index), substr($digits, $index+$length));
    }
}
