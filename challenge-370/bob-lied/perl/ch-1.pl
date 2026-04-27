#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
#  
# ch-1.pl Perl Weekly Challenge 370 Task 1 Popular Word
#=============================================================================
# You are given a string paragraph and an array of the banned words.
# Write a script to return the most popular word that is not banned. It is
# guaranteed there is at least one word that is not banned and the answer
# is unique. The words in paragraph are case-insensitive and the answer
# should be in lowercase. The words can not contain punctuation symbols.
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

my $P = shift;
say popword($P, [ @ARGV ] );

#=============================================================================
sub popword($paragraph, $banned)
{
    use List::MoreUtils qw/frequency/;
    my %freq = frequency split(" ", trim(lc($paragraph =~ s/[[:punct:]]+/ /gr)));
    delete @freq{$banned->@*};
    return (sort { $freq{$b} <=> $freq{$a} } keys %freq)[0];
}

sub runTest
{
    use Test2::V0;

    my @case = (
    { desc => "Example 1",
      paragraph => "Bob hit a ball, the hit BALL flew far after it was hit.",
      banned => ["hit"],
      expect => "ball",
    },
    { desc => "Example 2",
      paragraph => "Apple? apple! Apple, pear, orange, pear, apple, orange.",
      banned => ["apple", "pear"],
      expect => "orange",
    },
    { desc => "Example 3",
      paragraph => "A. a, a! A. B. b. b.",
      banned => ["b"],
      expect => "a",
    },
    { desc => "Example 4",
      paragraph => "Ball.ball,ball:apple!apple.banana",
      banned => ["ball"],
      expect => "apple",
    },
    { desc => "Example 5",
	  paragraph => "The dog chased the cat, but the dog was faster than the cat.",
      banned => ["the", "dog"],
      expect => "cat",
    }
    );


    for ( @case )
    {
        is( popword($_->{paragraph}, $_->{banned}), $_->{expect}, $_->{desc});
    }
    done_testing;
}
