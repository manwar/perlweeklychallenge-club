#!/usr/bin/env perl

# Perl Weekly Challenge 184 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-184/

use Modern::Perl;

sub split_one {
    my(@in) = @_;
    my(@num, @letters);
    for (@in) {
        if (/^\d+$/) {
            push @num, $_;
        }
        else {
            push @letters, $_;
        }
    }
    return \@num, \@letters;
}

sub split_array {
    my(@a) = @_;
    my(@num, @letters);
    for (@a) {
        my($this_num, $this_letters) = split_one(split ' ', $_);
        push @num, $this_num if @$this_num;
        push @letters, $this_letters if @$this_letters;
    }
    my @result = (\@num, \@letters);
    return @result;
}

sub print_result {
    my($num, $letters) = @_;
    print "[", join(", ", map {"[".join(",", @$_)."]"} @$num), "]";
    print " and ";
    print "[", join(", ", map {"[".join(",", map {"'$_'"} @$_)."]"} @$letters), "]";
    print "\n";
}

@ARGV or die "usage: ch-2.pl list...\n";
print_result(split_array(@ARGV));
