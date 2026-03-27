#!/usr/bin/env perl

# Perl Weekly Challenge 189 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-189/

use Modern::Perl;

sub greater_char {
    my($list, $char)=@_;
    my @list=grep {$_ gt $char} sort @$list;
    return @list ? $list[0] : $char;
}

@ARGV==2 or die "usage: ch-1.pl chars ch\n";
my @list=split //, shift;
my $char=shift;
say greater_char(\@list, $char);
