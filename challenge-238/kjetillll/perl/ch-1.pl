#!/usr/bin/perl
use strict; use warnings;

sub running_sum {
    my($first,@rest)=@_;
    @rest ? do{ $rest[0]+=$first; $first, running_sum(@rest) }
          : $first
}

@ARGV ? run_args(@ARGV)
      : run_tests();

sub run_args {
    print "@{[ &running_sum ]}\n"
}

sub run_tests {
    for my $test (
	[ [1, 2, 3, 4, 5],      => [1, 3, 6, 10, 15] ],
	[ [1, 1, 1, 1, 1],      => [1, 2, 3, 4, 5]   ],
	[ [0, -1, 1, 2],        => [0, -1, 0, 2 ]    ]
	){
	my($input,$expected)=@$test;
	my @got = running_sum(@$input);
	print "@$expected" eq "@got" ? 'ok' : '***NOT OK';
	print "   input: @$input    expected: @$expected    got: @got\n";
    }
}

