#!/usr/bin/perl
use strict; use warnings;

sub steps {
    my $n=pop;
    my @digits=$n=~/\d/g;
    my $p=eval join'*', @digits;
    $p>9?1+steps($p):1
}

sub sort_persistence {
    map $$_{value},
    sort { $$a{steps}<=>$$b{steps} or
           $$a{value}<=>$$b{value} }
    map{ {steps=>steps($_), value=>$_} }
    @_
}

@ARGV ? run_args(@ARGV)
      : run_tests();

sub run_args {
    print "@{[ &sort_persistence ]}\n"
}

sub run_tests {
    for my $test (
	[ [15, 99, 1, 34] => [1, 15, 34, 99] ],
	[ [50, 25, 33, 22] => [22, 33, 50, 25] ],
    ){
	my($input,$expected)=@$test;
	my @got = sort_persistence(@$input);
	print "@$expected" eq "@got" ? 'ok' : '***NOT OK';
	print "   input: @$input    expected: @$expected    got: @got\n";
    }
}

