#!/usr/bin/env perl
# Perl weekly challenge 099
# Task 2: unique subsequence
#
# See https://wlmb.github.io/2021/02/08/PWC099/#task-2-unique-subsequence


  use warnings;
  use strict;
  use v5.12;
  use Memoize;

  memoize qw(sequences);
  my ($S, $T)=@ARGV;
  my @sequences=sequences($S, $T);
  say "Input: \$S=\"$S\", \$T=\"$T\"";
  say "Output: ", scalar @sequences;
  say "$_: $sequences[$_-1]" for (1..@sequences);
  sub sequences { #Recursively find all matches of $S to $T
      my ($S, $T)=@_;
      return ("$S") if $T=~/^$/; #nothing more to match
      return () if $S=~/^$/; #end of string without match
      my ($firstS, $firstT)=map {escape(substr $_,0,1)} $S, $T;
      my ($restS, $restT)=map {substr $_,1} $S, $T;
      my @sequences=();
      @sequences=(map {"[$firstS]$_"} sequences($restS, $restT)) if $firstS eq $firstT;
      @sequences=(@sequences, map {"$firstS$_"} sequences($restS, $T));
      return @sequences;
  }
  sub escape { #Escape brackets
      my $string=shift;
      $string=~s/([][])/\\$1/g;
      return $string;
  }
