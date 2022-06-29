#!/usr/bin/env perl
# Perl weekly challenge 171
# Task 2: First class function
#
# See https://wlmb.github.io/2022/06/27/PWC171/#task-2-first-class-function
use v5.36;
die <<END unless @ARGV>=2;
Usage: .ch-2.pl "sub{...}" "sub{...}" arg1 arg2...
to compose two functions and apply them to the given arguments
END
my ($f, $g)=map {eval $_ or die $@} my ($fs, $gs)=(shift, shift);
my $h=compose($f, $g);
say "$fs ∘ $gs : ", join(", ", @ARGV), " ↦ ", $h->(@ARGV);

sub compose($f, $g){
    sub {$f->($g->(@_))};
}
