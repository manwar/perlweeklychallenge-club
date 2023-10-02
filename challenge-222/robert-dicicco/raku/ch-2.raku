#!/usr/bin/env raku
=begin comment
-----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-22
Challenge 222 Task 2 Last Member ( Raku )
-----------------------------------------------
=end comment

unit sub MAIN (*@allints where @allints.elems > 0) {
    say "Input: \@ints = ",@allints;
    loop {
        my @srt = @allints.sort;
        my $ln = @allints.elems - 1;
        if $ln <= 1 {
            say "Output: $ln\n";
            exit;
        } else {
            my $lrg = @srt[$ln];
            my $nxt = @srt[$ln-1];

            my $index =  @allints.first($lrg, :k);
            @allints.splice($index,1);

            $index =  @allints.first($nxt, :k);
            @allints.splice($index,1);

            if ($lrg > $nxt) {
                @allints.prepend($lrg - $nxt);
            }
        }
    }
}

=begin comment
-----------------------------------------------
SAMPLE OUTPUT
raku .\LastMember.rk 2 7 4 1 8
Input: @ints = [2 7 4 1 8]
Output: 1

raku .\LastMember.rk 1 1
Input: @ints = [1 1]
Output: 1

raku .\LastMember.rk 1
Input: @ints = [1]
Output: 0
-----------------------------------------------
=end comment


