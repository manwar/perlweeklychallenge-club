#!/usr/bin/env perl
=begin comment
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-09
Challenge 229 Two Out Of Three  Task 2 ( Perl )
------------------------------------------------
=cut
use v5.38;
use List::MoreUtils qw(uniq);

#my @arrays = ([1, 1, 2, 4,],[2, 4],[4]);
my @arrays = ([4, 1],[2, 4],[1, 2]);

my %hash = ();
my $cnt = 1;
my (@array1,@array2,@array3) = ();

sub CreateCounts(@a) {
    for my $i (@a) {
        if (exists ($hash{$i})) {
            $hash{$i}++;
        } else {
            $hash{$i} = 1;
        }
    }
}

for my $a (@arrays) {
    my @a_uniq = uniq @$a;
    if ($cnt == 1) {
        @array1 = @a_uniq;
        CreateCounts(@array1);
        say "Input:  \@array1 = (@array1)";
    } elsif ($cnt == 2) {
        @array2 = @a_uniq;
        CreateCounts(@array2);
        say "\t\@array2 = (@array2)";
    } elsif ($cnt == 3) {
        @array3 = @a_uniq;
        CreateCounts(@array3);
        say "\t\@array3 = (@array3)";
    } else {
        print("ERROR!");
        exit;
    }
    $cnt++;
}

print("Output: ( ");
for my $key (keys %hash) {
    if ($hash{$key} >= 2 ){
        print("$key ");
    }
}

print(" \)");

=begin comment
------------------------------------------------
SAMPLE OUTPUT
perl .\TwoThree.pl
Input:  @array1 = (1 2 4)
        @array2 = (2 4)
        @array3 = (4)
Output: ( 4 2  )

perl .\TwoThree.pl
Input:  @array1 = (4 1)
        @array2 = (2 4)
        @array3 = (1 2)
Output: ( 4 1 2  )

------------------------------------------------
=cut


