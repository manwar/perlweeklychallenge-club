use strict; use warnings;

@ARGV ? run_args(@ARGV)
      : run_tests();

sub count_reverse_pairs {
    my $indexes=join',',0..$#_;
    scalar
    grep { my($i,$j)=split/_/; $i<$j and $_[$i]>2*$_[$j] }
    glob "{$indexes}_{$indexes}"
}

sub run_args { print count_reverse_pairs(@_) }

sub run_tests {
    for my $test (
        [ [1,3,2,3,1] => 2 ],
        [ [2,4,3,5,1] => 3 ],
    ){
        my($input,$expected)=@$test;
        my $got = count_reverse_pairs(@$input);
        print $expected == $got ? 'ok' : '***NOT OK';
        print "   input: @$input    expected: $expected    got: $got\n";
    }
}

