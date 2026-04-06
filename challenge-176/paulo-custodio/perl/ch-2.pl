#!/usr/bin/env perl

# Perl Weekly Challenge 176 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-176/

use Modern::Perl;

sub is_reversible {
    my($n) = @_;
    my $rev = join '', reverse split //, $n;
    return ($n+$rev) =~ /^[13579]+$/;
}

sub reversibles_up_to {
    my($N) = @_;
    my $n = 1;
    my @result;
    while ($n < $N) {
        push @result, $n if is_reversible($n);
        $n++;
    }
    return @result;
}

@ARGV==1 or die "usage: ch-2.pl N\n";
my $N = shift;
say "(", join(", ", reversibles_up_to($N)), ")";
