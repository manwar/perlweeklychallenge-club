#!/usr/bin/env perl6
use v6;

# run as <script> <RPN expression>

sub prcs_stack(@stack,$token) {
    ($token.Real) ?? (|@stack, $token) !! (|@stack[0..^*-2], @stack.[*-2..*-1].join($token).EVAL)
}

say (reduce &prcs_stack, [], |@*ARGS)
