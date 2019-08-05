use v6;

################################################################################
=begin comment

Perl Weekly Challenge 014
=========================

Challenge #1
------------

Write a script to generate Van Eck's sequence starts with 0. For more
information, please check out wikipedia
[ https://en.wikipedia.org/wiki/Van_Eck%27s_sequence |page]. This challenge was
proposed by team member *Andrezgz*.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my Int constant $LENGTH = 27;

sub MAIN(Int:D $length = $LENGTH)
{
    say "\nThe first $length terms in Van Eck's sequence are:\n",
         van-eck($length).join(', ');
}

sub van-eck(Int:D $length --> Array)
{
    my @seq = (Nil, 0);
    my %indices;

    for 1 .. $length - 1 -> Int $n
    {
        my $old_term = @seq[$n];
		push @seq, %indices{$old_term}:exists ?? $n - %indices{$old_term} !! 0;
        %indices{$old_term} = $n;
    }

    shift  @seq;
    return @seq;
}

################################################################################
