use warnings;
use feature "say";

sub rearrange {
    my @in = @{$_[0]};
    my $size = $_[1];
    my @result;
    return "-1" if @in % $size;
    my %bag;
    $bag{$_}++ for @in;
    while (%bag) {
        my $min = (sort { $a <=> $b } keys %bag)[0];
        my @list = $min..($min + $size -1);
        for my $item (@list) {
            return "-1" unless exists $bag{$item};
            $bag{$item}--;
            delete $bag{$item} if $bag{$item} == 0;
        }
        push @result, \@list;
    }
    return @result;
}

for my $test( [[1,2,3,5,1,2,7,6,3], 3],
              [[1,2,3], 2], [[1,2,3], 3],
              [[1,2,4,3,5,3], 3],
              [[1,5,2,6,4,7], 3],
              [[1,5,2,6,4,7], 2] )
              {
    say "(@{$test->[0]})", " ", "($test->[1])";
    my @result = rearrange(@$test);
    if ($result[0] == "-1") {
        say -1;
    } else {
        say map { "[@$_] " } @result;
    }
    say " ";
}
