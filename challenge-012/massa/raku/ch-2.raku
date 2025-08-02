#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Merge items

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given two 2-D array of positive integers, $items1 and $items2 where
element is pair of (item_id, item_quantity).

Write a script to return the merged items.

=head3 Example 1:

    Input:  «/a/b/c/d /a/b/cd /a/b/cc /a/b/c/d/e»
    Output: "/a/b"

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION(*@paths is copy) {
  my @parts = map { last unless [eq] $_[]; $_[0] }, [Z] (@paths ==> map {$*SPEC.splitdir: .IO});
  $*SPEC.catdir: @parts
}

multi MAIN (Bool :$test!) {
    use Testo;

    my @tests =
        %{ input =>  «/a/b/c/d /a/b/cd /a/b/cc /a/b/c/d/e»,
           output => "/a/b" },
        %{ input => «
              /etc/apt/listchanges.conf.d /etc/apt/sources.list /etc/apt/sources.list.d
              /etc/apt/sources.list.dpkg-backup /etc/apt/sources.list.save
              /etc/apt/sources.list~ /etc/apt/apt.conf.d/20listchanges
              /etc/apt/sources.list.d/google-chrome.list
              /etc/apt/sources.list.d/google-chrome.list.save
              /etc/apt/sources.list.d/nala-sources.list /etc/apt/sources.list.d/nala.list
              /etc/apt/sources.list.d/steam.list.save »,
          output => "/etc/apt" },
    ;

    SOLUTION(|.<input>).&is: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


