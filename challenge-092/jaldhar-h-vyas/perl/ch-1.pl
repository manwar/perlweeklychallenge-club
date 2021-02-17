#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
  $PROGRAM_NAME <A> <B>
  
    <A>    a string
    <B>    another string
-USAGE-
    exit 0;
}

sub isIsomorphic {
    my ($A, $B) = @_;

    if (length $A != length $B) {
        return undef;
    }

    my @A = split //, $A;
    my @B = split //, $B;
    my %seen;
    my %isomorphs;

    for my $i (0 .. scalar @A - 1) {
        my $a = $A[$i];
        my $b = $B[$i];

        if (exists $isomorphs{$a}) {
            unless ($b eq $isomorphs{$a}) {
                return undef;
            }
        } else {
            if (!grep /$b/, keys %seen) {
                $isomorphs{$a} = $b;
                $seen{$b} = 1;
            } else {
                return undef;
            }
        }
    }

    return 1;
}

if (scalar @ARGV != 2) {
    usage;
}

say isIsomorphic($ARGV[0], $ARGV[1]) ? 1 : 0;
