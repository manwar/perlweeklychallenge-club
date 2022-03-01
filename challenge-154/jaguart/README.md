Challenge-154 Missing Permutation
=================================

TASK #1: Missing Permutation

You are given possible permutations of the string 'PERL'. Write a script to find any permutations missing from the list.

SYNOPSIS
========

      ./ch-1.raku PERL | wc -l # 24 permutations
      ./ch-1.raku PERL LERP ERPL | wc -l # 22 permutations

CAVEATS
=======

Does NOT filter out duplicates when the same character occurs multiple times.

      ./ch-1.raku aab
      aab
      aba
      aab
      aba
      baa
      baa

AUTHOR
======

Solutions by git:jaguart Jeff Armstrong.

NOTE
====

  * First contribution to https://theweeklychallenge.org/

  * Raku newbie, ex Perl

Challenge-154 Padovan Primes
============================

TASK #2: Padovan Prime

Write a script to compute first 10 distinct Padovan Primes.

SYNOPSIS
========

      ./ch-2
      # 2
      # 3
      # 5
      # 7
      # 37
      # 151
      # 3329
      # 23833
      # 13091204281
      # 3093215881333057

      ./ch-2.raku 12
      # 2
      # 3
      # 5
      # 7
      # 37
      # 151
      # 3329
      # 23833
      # 13091204281
      # 3093215881333057
      # 1363005552434666078217421284621279933627102780881053358473
      # 1558877695141608507751098941899265975115403618621811951868598809164180630185566719

CAVEATS
=======

  * Get's big quickly

  * Uses Raku ``.is-prime`` approximation to determine primeness.

AUTHOR
======

Solutions by git:jaguart Jeff Armstrong.

