#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 383 Task 1  Similar List
#=============================================================================
# # You are given three list of strings. Write a script to find out if the
# first two list are similar with the help the third list. The third list
# contains the similar words map.
# Example 1 Input: $list1 = ("great", "acting")
#                  $list2 = ("fine", "drama")
#                  $list3 = (["great", "fine"], ["acting", "drama"])
#       Output: true
# Example 2 Input: $list1 = ("apple", "pie")
#                  $list2 = ("banana", "pie")
#                  $list3 = (["apple", "peach"], ["peach", "banana"])
#       Output: false
# Example 3 Input: $list1 = ("perl4", "python")
#                  $list2 = ("raku", "python")
#                  $list3 = (["perl4", "perl5", "raku"])
#       Output: true
# Example 4 Input: $list1 = ("enjoy", "challenge")
#                  $list2 = ("love", "weekly", "challenge")
#                  $list3 = (["enjoy", "love"])
#       Output: false
# Example 5 Input: $list1 = ("fast", "car")
#                  $list2 = ("quick", "vehicle")
#                  $list3 = (["quick", "fast"], ["vehicle", "car"])
#       Output: true
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

# Give list1 and list2 as comma-separated values, then
# lists of synonyms as more comma-separated values.
# Example: perl ch-1.pl red,apple yellow,banana  red,yellow apple,banana
my @List1 = split(",", shift);
my @List2 = split(",", shift);
my @List3 = map { [ split(",", $_) ] } @ARGV;

say task(\@List1, \@List2, \@List3) ? "true" : "false";

#=============================================================================

use feature 'class'; no warnings 'experimental::class';

class Thesaurus
{
    my %thesaurus;

    method addSynonym($list) {
        for my ($at, $word) ( indexed @$list )
        {
            for my $substitute ( $list->@[$at+1 .. $list->$#*] )
            {
                $thesaurus{ $word }{ $substitute } =
                $thesaurus{ $substitute }{ $word } = true;
            }
        }
    }

    method isSynonym($word, $otherWord) {
        return $thesaurus{ $word }{ $otherWord }
            || $thesaurus{ $otherWord }{ $word };
    }
}

sub task($list1, $list2, $list3)
{
    return false if $list1->$#* != $list2->$#*; # Different sizes

    my $thesaurus = Thesaurus->new();

    $thesaurus->addSynonym($_) for $list3->@*;

    for my ($at, $word) ( indexed @$list1 )
    {
        my $otherWord = $list2->[$at];
        if ( $word ne $otherWord )
        {
            return false unless $thesaurus->isSynonym($word, $otherWord);
        }
    }
    return true;
}

sub runTest
{
    use Test2::V1 -ipP;

    my @case = (
    { desc => "Example 1", expect => true,
      list1 => ["great", "acting"],
      list2 => ["fine", "drama"],
      list3 => [["great", "fine"], ["acting", "drama"]],
    },
    { desc => "Example 2", expect => false,
      list1 => ["apple", "pie"],
      list2 => ["banana", "pie"],
      list3 => [["apple", "peach"], ["peach", "banana"]],
    },
    { desc => "Example 3", expect => true,
      list1 => ["perl4", "python"],
      list2 => ["raku", "python"],
      list3 => [["perl4", "perl5", "raku"]],
    },
    { desc => "Example 4", expect => false,
      list1 => ["enjoy", "challenge"],
      list2 => ["love", "weekly", "challenge"],
      list3 => [["enjoy", "love"]],
    },
    { desc => "Example 5", expect => true,
      list1 => ["fast", "car"],
      list2 => ["quick", "vehicle"],
      list3 => [["quick", "fast"], ["vehicle", "car"]],
    },
    );

    for my $c ( @case )
    {
        is( task($c->{list1}, $c->{list2}, $c->{list3}), $c->{expect}, $c->{desc});
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
