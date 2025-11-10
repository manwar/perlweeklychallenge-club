use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

my @operations = ('*', '+', '-');

sub all_substring_splits($str, $prefix) {
    $prefix //= [];
    my @results;

    if ($str eq '') {
        push @results, [@$prefix];
        return @results;
    }

    for my $i (1 .. length($str)) {
        my $first = substr($str, 0, $i);
        my $rest  = substr($str, $i);
        push @results, all_substring_splits($rest, [@$prefix, $first]);
    }

    return @results;
}

sub add_operators($list, @result) {
    if (scalar(@$list)) {
        my $left = shift @$list;
        my @local;
        if (scalar(@result)) {
            foreach my $r (@result) {
                if (scalar(@$list)) {
                    foreach my $operator (@operations) {
                        push @local, "$r$left$operator";
                    }
                } else {
                    push @local, "$r$left";
                }
            }
        } else {
            foreach my $operator (@operations) {
                push @local, "$left$operator";
            }
        }
        @result = @local;

        foreach my $part (@$list) {
            @result = add_operators($list, @result);
        }
    }
    return @result;
}


sub run($str, $target) {
    my @result;
    foreach my $candidate_list (all_substring_splits($str, undef)) {
        next if scalar(@$candidate_list == 1);
        next if grep /^0\d/, @$candidate_list;
        foreach my $eval (add_operators($candidate_list)) {
            push @result, $eval if $target == eval $eval;
        }
    }
    return \@result;
}

is_deeply(run("123", 6), ["1*2*3", "1+2+3"], "Example 1");
is_deeply(run("105", 5), ["1*0+5", "10-5"], "Example 2");
is_deeply(run("232", 8), ["2*3+2", "2+3*2"], "Example 3");
is_deeply(run("1234", 10), ["1*2*3+4", "1+2+3+4"], "Example 4");
is_deeply(run("1001", 2), ["1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1"], "Example 5");
