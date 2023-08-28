#!/usr/bin/env raku
=begin comment
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-09
Challenge 229 Two Out Of Three  Task 2 ( Raku )
------------------------------------------------
=end comment
use v6;
my @arrays = ([1, 1, 2, 4,],[2, 4],[4]);
#my @arrays = ([4, 1],[2, 4],[1, 2]);

my %hash = ();
my $cnt = 1;
my (@array1,@array2,@array3) = ();

sub CreateCounts(@a) {
    for @a -> $i {
        if (defined (%hash{$i})) {
            %hash{$i}++;
        } else {
            %hash{$i} = 1;
        }
    }
}

for (@arrays) -> @a {
    my @a_uniq = @a.unique;
    if ($cnt == 1) {
        @array1 = @a_uniq;
        CreateCounts(@array1);
        say "Input:  \@array1 = ",@array1;
    } elsif ($cnt == 2) {
        @array2 = @a_uniq;
        CreateCounts(@array2);
        say "\t\@array2 = ",@array2;
    } elsif ($cnt == 3) {
        @array3 = @a_uniq;
        CreateCounts(@array3);
        say "\t\@array3 = ",@array3;
    } else {
        print("ERROR!");
        exit;
    }
    $cnt++;
}

print("Output: ( ");
for %hash.kv -> $key, $val {
    if %hash{$key} >= 2 {
        print("$key ");
    }
}

print(" \)");

=begin comment
------------------------------------------------
SAMPLE OUTPUT
raku .\TwoThree.rk
Input:  @array1 = [1 2 4]
        @array2 = [2 4]
        @array3 = [4]
Output: ( 2 4  )

raku .\TwoThree.rk
Input:  @array1 = [4 1]
        @array2 = [2 4]
        @array3 = [1 2]
Output: ( 4 2 1  )
------------------------------------------------
=end comment


