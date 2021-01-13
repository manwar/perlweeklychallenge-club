#! /opt/local/bin/perl5.26
#
#       dna.pl
#
#         TASK #1 › DNA Sequence
#         Submitted by: Mohammad S Anwar
#
#         DNA is a long, chainlike molecule which has two strands twisted into a
#         double helix. The two strands are made up of simpler molecules called
#         nucleotides. Each nucleotide is composed of one of the four
#         nitrogen-containing nucleobases cytosine (C), guanine (G), adenine (A)
#         and thymine (T).
#
#         You are given DNA sequence,
#
#             GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG.
#
#         Write a script to print nucleiobase count in the given DNA sequence.
#         Also print the complementary sequence where Thymine (T) on one strand
#         is always facing an adenine (A) and vice versa; guanine (G) is always
#         facing a cytosine (C) and vice versa.
#
#         To get the complementary sequence use the following mapping:
#
#             T => A
#             A => T
#             G => C
#             C => G
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

use Benchmark 'cmpthese';


## ## ## ## ## MAIN:

my $seq = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';


say "seq:    ", $seq;

say "length  : ", length $seq;
say "thymine : ", $seq =~ tr/T/1/;
say "adenine : ", $seq =~ tr/A/2/;
say "guanine : ", $seq =~ tr/G/3/;
say "cytosine: ", $seq =~ tr/C/4/;

$seq =~ tr/1234/ATCG/;

say "comp:   ", $seq;








## ## ## ## ## SUBS:


sub translate {
    my $seq = shift;
    my $T =  $seq =~ tr/T/1/;
    my $A =  $seq =~ tr/A/2/;
    my $G =  $seq =~ tr/G/3/;
    my $C =  $seq =~ tr/C/4/;
    my $len = $seq =~ tr/1234/ATCG/;

    return ( $len, $T, $A, $G, $C, $seq );
}


sub count {
    my $seq = shift;
    my @arr = split //, $seq;
    my %map = ( 'T' => 'A',
                'A' => 'T',
                'G' => 'C',
                'C' => 'G' );
    my %c;
    my @output;
    for ( @arr ) {
        $c{$_}++;
        push @output, $map{$_};
    }
    $seq = join '', @output;

    return (length($seq), $c{T}, $c{A}, $c{G}, $c{C}, $seq);
}


use Benchmark qw{ cmpthese };
cmpthese(-3, {
    trans => sub { translate($seq) },
    array => sub { count($seq) },
});

__END__

