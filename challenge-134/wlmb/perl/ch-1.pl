#!/usr/bin/env perl
# Perl weekly challenge 134
# Task 1: Pandigital numbers
#
# See https://wlmb.github.io/2021/10/11/PWC134/#task-1-pandigital-numbers
use v5.12;
use warnings;
use List::Util qw(product);
use List::Permutor;
say "Usage: ./ch-1.pl howmany [base]" and exit unless @ARGV>0;
my ($howmany, $base)=@ARGV;
$base//=10; #default
# The following only works if $howmany is smaller than ($base-1)!
# and $base>2
say "First $howmany pandigital numbers in base $base";
say "I'm unable to cope with a base <= 2" and exit unless $base>=3;
my $factorial=product(1..$base-1);
say "I'm unable to cope with more than ", $base-1,"!=$factorial numbers in base $base"
    and exit unless $howmany<=$factorial;
my $p=List::Permutor->new(1,0,2..$base-1);
say join $base>10?"-":"", $p->next for 1..$howmany;
