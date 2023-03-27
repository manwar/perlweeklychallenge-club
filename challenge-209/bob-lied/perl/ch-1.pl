#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 209 Task 1 Special Bit Charactioners 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of binary bits that ends with 0.
# Valid sequences in the bit string are:
#   [0] -decodes-to-> "a"
#   [1, 0] -> "b"
#   [1, 1] -> "c"
# Write a script to print 1 if the last charactioner is an “a” otherwise print 0.
# Example 1 Input: @bits = (1, 0, 0) Output: 1
#   The given array bits can be decoded as 2-bits charactioner (10) followed
#   by 1-bit charactioner (0).
# Example 2 Input: @bits = (1, 1, 1, 0) Output: 0
#   Possible decode can be 2-bits charactioner (11) followed by 2-bits charactioner
#   (10) i.e. the last charactioner is not 1-bit charactioner.
#---------
# Recognizing bit sequences is a good use of state machines.  If we end in
# state a, then we have a valid sequence.
#
#                                                  
#                   +------+                       
#                   |      |                       
#               +---v---+ -|                       
#               |       |--+                       
#               |       |<--------------------+    
#         +---->|   a   |<--------+           |    
#         |     |       |         |           |    
#         |0    +-------+        0|           |    
# +----------+    |          1  +--------+    |    
# | Start    |   1|   +---------|   b    |    |    
# +----------+    |   |         +--------+    |    
#         |1      v   v           ^           |    
#         |     +-------+ 0       |           |    
#         +---->|       |---------+           |    
#               |  bc   |-----------------+   |    
#               +-------+ 1               |   |    
#                     ^                   v   |0   
#                     |              1  +-------+  
#                     +-----------------|   c   |  
#                                       +-------+  
#
# This state machine can be represented as a table that maps a current state
# and input to a next state.  The 'b' and 'c' states could be combined.
#
#
# Current State |  0  |  1  |
# --------------+=====+=====+
#          Start|  a  |  bc |
#              a|  a  |  bc |
#             bc|  b  |   c |
#              b|  a  |  bc |
#              c|  a  |  bc |
#
# We can extend the state machine to decode the output, not just test it,
# by adding an action that emits the character to transitions where a
# character is recognized.
#=============================================================================

use v5.36;

use builtin qw(false true); no warnings "experimental::builtin";

use enum qw(:ST_  START A B C BC);

my @StateMachineValidate;
#                 current state       0      1
#                    ----------     ----  -----
$StateMachineValidate[ST_START] = [ ST_A, ST_BC ];
$StateMachineValidate[ST_A    ] = [ ST_A, ST_BC ];
$StateMachineValidate[ST_BC   ] = [ ST_B, ST_C  ];
$StateMachineValidate[ST_B    ] = [ ST_A, ST_BC ];
$StateMachineValidate[ST_C    ] = [ ST_A, ST_BC ];

my @StateMachineDecode;
$StateMachineDecode[ST_START] = [ { next => ST_A,  action => sub { 'a' } },
                                  { next => ST_BC, action => sub {     } } ];

$StateMachineDecode[ST_A    ] = [ { next => ST_A,  action => sub { 'a' } },
                                  { next => ST_BC, action => sub {     } } ];

$StateMachineDecode[ST_BC   ] = [ { next => ST_B,  action => sub { 'b' } },
                                  { next => ST_C,  action => sub { 'c' } } ];

$StateMachineDecode[ST_B    ] = [ { next => ST_A,  action => sub { 'a' } },
                                  { next => ST_BC, action => sub {     } } ];

$StateMachineDecode[ST_C    ] = [ { next => ST_A,  action => sub { 'a' } },
                                  { next => ST_BC, action => sub {     } } ];

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say decodeSeq(\@ARGV, $Verbose);

sub isValidInput($in)
{
    if ( not ( $in == 1 || $in == 0 ) )
    {
        warn "Unexpected input: $in";
        return false;
    }
    return true;
}  

sub validateSeq($bit)
{
    my $state = ST_START;
    while ( defined ( my $input = shift @$bit ) )
    {
        return 0 if ( not isValidInput($input) );
        $state = $StateMachineValidate[$state][$input];
    }
    return $state == ST_A ? 1 : 0;
}

sub onTransition($out, $val) { push @$out, $val; }

sub decodeSeq($bit, $show=false)
{
    my @output;
    my $state = ST_START;
    while ( defined ( my $input = shift @$bit ) )
    {
        return 0 if ( not isValidInput($input) );

        my $transition = $StateMachineDecode[$state][$input];
        $state = $transition->{next};
        push @output, $transition->{action}();
    }
    my $isValid = ( $state == ST_A ? 1 : 0 );

    say join("", @output) if $show && $isValid;
    return $isValid;
}

sub runTest
{
    use Test2::V0;

    is( decodeSeq([1,0,0  ]), 1, "Example 1");
    is( decodeSeq([1,1,1,0]), 0, "Example 2");

    is( decodeSeq([0,0,0,0]), 1, "aaaa");
    is( decodeSeq([1,1,0,0]), 1, "caa");
    is( decodeSeq([0,1,0,0]), 1, "aba");
    is( decodeSeq([0,1,0,1,1]), 0, "abc");

    done_testing;
}
