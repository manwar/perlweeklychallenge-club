#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 067 Task 2  Letter Phone
#=============================================================================
# You are given a digit string $S. Write a script to print all possible letter
# combinations that the given digit string could represent.
# 1 -> _,@    2 -> abc   3 -> def
# 4 -> ghi    5 -> jkl   6 -> mno
# 7 -> pqrs   8 -> tuv   9 -> wxyz
# 0 -> " "    # ->       * -> 
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

my %Phone = ( 1  => [ '_',',','@' ], 2   => [ qw(a b c) ], 3   => [ qw(d e f)   ],
              4  => [ qw(g h i)   ], 5   => [ qw(j k l) ], 6   => [ qw(m m o)   ],
              7  => [ qw(p q r s) ], 8   => [ qw(t u v) ], 9   => [ qw(w x y z) ],
              0  => [ ""          ], '#' => [ ""        ], '*' => [ " "         ],
          );

exit(!runTest()) if $DoTest;

say '[', join(", ", map { qq("$_") } phone($_)->@*), ']' for @ARGV;

#=============================================================================
sub phone($s)
{
    my @digit = split(//, $s);
    my @stringList = ( $Phone{shift @digit}->@* );
    while ( defined(my $d = shift @digit) )
    {
        my @letter = $Phone{$d}->@*;
        
        my @t;
        for my $s ( @stringList )
        {
            push @t, ( map { "$s$_" } @letter );
        }
        @stringList = @t;

    }
    return [ sort  @stringList ];
}

sub runTest
{
    use Test2::V0;

    is( phone( "2"), [qw(a b c)], "s=2");
    is( phone("35"), [qw( dj dk dl ej ek el fj fk fl)], "s=35");

    done_testing;
}
