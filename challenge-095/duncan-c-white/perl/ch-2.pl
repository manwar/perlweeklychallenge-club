#!/usr/bin/perl
# 
# Task 2: "Demo Stack
# 
# Write a script to demonstrate Stack operations like below:
# 
# push($n) - add $n to the stack
# pop() - remove the top element
# top() - get the top element
# min() - return the minimum element
# 
# Example:
# 
# my $stack = Stack->new;
# $stack->push(2);
# $stack->push(-1);
# $stack->push(0);
# $stack->pop;       # removes 0
# print $stack->top; # prints -1
# $stack->push(0);
# print $stack->min; # prints -1
# "
# 
# My notes: ok so by "script" we mean "Perl class".  Very easy to do,
# but I wonder what ch-2.pl does - contains the above example I guess.
# On second thought, let's inline the Stack module into here..
# 
use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;
use List::Util;

my $debug=0;
die "Usage: ch-2 [--debug]\n" unless GetOptions( "debug" => \$debug ) && @ARGV==0;


package Stack;

use overload '""' => \&as_string;

#
# my $Stack = Stack->new( @n );
#	create a Stack node with the elements in @n on it
#
method new($class: @n )
{
	my $stack = bless [
		'Stack', @n
	], $class;
	say "debug: new stack: $stack" if $debug;
	return $stack;
}


#
# $stack->push($n);
#	Push $n onto stack $s.
#
method push( $n )
{
	CORE::push @$self, $n;
	say "debug: pushed $n onto stack: $self" if $debug;
}


#
# my $isempty = $stack->isempty();
#	Return 1 iff $stack is empty, otherwise 0.
#
method isempty()
{
	my $isempty = @$self==1 ? 1 : 0;
	say "debug: isempty($self) = $isempty" if $debug;
	return $isempty;
}


#
# my $x = $stack->top();
#	Return the top value of $stack (without changing it).
#	Abort if $stack is empty.
#
method top(  )
{
	die "Stack->top: stack is already empty\n" if @$self==1;
	my $top = $self->[1];
	say "debug: top($self) = $top" if $debug;
	return $top;
}


#
# my $x = $stack->pop();
#	Pop the top value of $stack off - returning it.
#	Abort if $stack is empty.
#
method pop(  )
{
	die "Stack->pop: stack is already empty\n" if @$self==1;
	my $before = "$self";
	my $top = splice( @$self, 1, 1 );
	say "debug: pop($before) = $top, stack now $self" if $debug;
	return $top;
}


#
# my $x = $stack->min();
#	Find the minimum value of $stack off - not changing it.
#	Abort if $stack is empty.
#
method min(  )
{
	die "Stack->min: stack is already empty\n" if @$self==1;
	my @x = @$self;
	shift @x;
	my $min = List::Util::min(@x);
	say "debug: min($self) = $min" if $debug;
	return $min;
}


#
# my $str = $Stack->as_string();
#	return the given $Stack as a nice printable string.
#
sub as_string($)
{
	my( $self ) = @_;

	die "Stack->as_string: bad Stack ", Dumper($self) unless ref($self) eq "Stack";
	my @x = @$self;
	my $kind = shift @x;
	return "[". join(',', map { "$_" } @x ). "]";
}


package main;

my $stack = Stack->new();
$stack->push(2);
$stack->push(-1);
$stack->push(0);
$stack->pop;       # removes 0
say "top = ", $stack->top; # prints -1
$stack->push(0);
say "min = ", $stack->min; # prints -1
