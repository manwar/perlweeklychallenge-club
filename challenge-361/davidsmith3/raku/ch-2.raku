#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 2
You are given a binary matrix (m x n).

Write a script to find the celebrity, return -1 when none found.

A celebrity is someone, everyone knows and knows nobody.
=CHALLENGE
=head3 Example 1:
Input: @party = (
            [0, 0, 0, 0, 1, 0],  # 0 knows 4
            [0, 0, 0, 0, 1, 0],  # 1 knows 4
            [0, 0, 0, 0, 1, 0],  # 2 knows 4
            [0, 0, 0, 0, 1, 0],  # 3 knows 4
            [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
            [0, 0, 0, 0, 1, 0],  # 5 knows 4
       );
Output: 4

=head3 Example 2:
Input: @party = (
            [0, 1, 0, 0],  # 0 knows 1
            [0, 0, 1, 0],  # 1 knows 2
            [0, 0, 0, 1],  # 2 knows 3
            [1, 0, 0, 0]   # 3 knows 0
       );
Output: -1

=head3 Example 3:
Input: @party = (
            [0, 0, 0, 0, 0],  # 0 knows NOBODY
            [1, 0, 0, 0, 0],  # 1 knows 0
            [1, 0, 0, 0, 0],  # 2 knows 0
            [1, 0, 0, 0, 0],  # 3 knows 0
            [1, 0, 0, 0, 0]   # 4 knows 0
       );
Output: 0

=head3 Example 4:
Input: @party = (
            [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
            [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
            [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
            [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
            [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
            [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
       );
Output: 3

=head3 Example 5:
Input: @party = (
            [0, 1, 1, 0],  # 0 knows 1 and 2
            [1, 0, 1, 0],  # 1 knows 0 and 2
            [0, 0, 0, 0],  # 2 knows NOBODY
            [0, 0, 0, 0]   # 3 knows NOBODY
       );
Output: -1

=head3 Example 6:
Input: @party = (
            [0, 0, 1, 1],  # 0 knows 2 and 3
            [1, 0, 0, 0],  # 1 knows 0
            [1, 1, 0, 1],  # 2 knows 0, 1 and 3
            [1, 1, 0, 0]   # 3 knows 0 and 1
      );
Output: -1

=end pod

sub my-sub(List $adj -->Int:D) {
    my $celebs = $adj.grep(*.none, :k);
    return -1 if $celebs.elems != 1;
    my $celeb = $celebs.head;

    my $everyone-knows = (^$adj.elems)
                               .grep(* != $celeb)
                               .map({$adj[$_][$celeb] == 1})
                               .all;
    $everyone-knows ?? $celeb !! -1;
} 

multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    plan +@tests;
    for @tests {
        is my-sub( .<input> ), .<output>;
    } 
}

sub extract-tests(-->Array[Hash]) {
    my Hash @tests;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / (\(.*\)) .* Output\:\s*(\-?\d+) / {
                my $input = $0.subst("[", "\n[", :g) ~ "\n)";
                @tests.push(%{ input => $input.EVAL, output => +$1 });
            }
        }
    }
    @tests;
}
