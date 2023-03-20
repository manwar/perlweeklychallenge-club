#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 174 Task 1 Disarium Numbers 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Write a script to generate first 19 Disarium Numbers.
# A disarium number is an integer where the sum of each digit raised to the
# power of its position in the number, is equal to the number.
# For example, 518 is a disarium number as
# (5 ** 1) + (1 ** 2) + (8 ** 3) => 5 + 1 + 512 => 518
#
# Googling for Disarium reveals that the only purpose of disarium numbers
# appears to be for programming challenges and interview questions.
# The first 19 are reasonable to calculate.  Number 20 is huge. Not clear if
# there are more than that.
#
# Since this seems to be a purely academic exercise, let's use it to practice
# making an object-oriented iterator class.
#=============================================================================

use v5.36;


package Disarium;
use Moo;

use List::Util qw/sum/;

has 'max' => ( is => 'ro',  required => 1 );
has 'd'   => ( is => 'rw',  default => 0 );
has '_count' => ( is => 'rw',  default => 0);

sub _isDisarium($n)
{
    my @digit = split(//, "$n");
    return $n == sum( map { $digit[$_] ** ($_+1) } 0 .. $#digit );
}

sub next($self)
{
    return undef if $self->_count >= $self->max;

    $self->{d}++ while ! _isDisarium($self->{d});
    $self->{_count}++;
    $self->{d}++;
    return $self->d - 1;
}

1;


use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $dIter = Disarium->new( max => ($ARGV[0] // 10) );
while ( defined (my $d = $dIter->next() ) ) { say $d }

sub runTest
{
    use Test2::V0;

    is(0, 1, "FAIL");

    done_testing;
}

