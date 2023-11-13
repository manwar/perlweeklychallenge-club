use strict; use warnings;

@ARGV ? run_args(@ARGV)
      : run_tests();

sub sum_of_floors {
    eval
    join '+',
    map { /_/; int($`/$') }
    glob "{@_}_{@_}" =~ s/ /,/gr
}

sub run_args { print sum_of_floors(@_) }

sub run_tests {
    for my $test (
        [ [2,5,9] => 10 ],
        [ [7,7,7,7,7,7,7] => 49 ],
    ){
        my($input,$expected)=@$test;
        my $got = sum_of_floors(@$input);
        print $expected == $got ? 'ok' : '***NOT OK';
        print "   input: @$input    expected: $expected    got: $got\n";
    }
}

