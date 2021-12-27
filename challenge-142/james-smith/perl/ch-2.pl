#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

use threads;
use threads::shared;
use Time::HiRes qw(sleep);

my @res :shared;
my @list=map{0.001*int rand 3000}1..20;

say "@list";

sub sleeper {sleep$_[0];push@res,$_[0]}

threads->new( \&sleeper, $_ ) for @list;

$_->join for threads->list;

say for @res;
