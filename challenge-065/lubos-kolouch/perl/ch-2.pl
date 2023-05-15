use strict;
use warnings;

sub is_palindrome {
    my $s = shift;
    return $s eq reverse($s);
}

sub palindrome_partitions {
    my ($s, $start, $current_partition, $result) = @_;
    if ($start == length($s)) {
        push @$result, [@$current_partition];
        return;
    }

    for my $end ($start + 1 .. length($s)) {
        my $substr = substr($s, $start, $end - $start);
        if (is_palindrome($substr)) {
            push @$current_partition, $substr;
            palindrome_partitions($s, $end, $current_partition, $result);
            pop @$current_partition;
        }
    }
}

my $S = 'aabaab';
my @result;

palindrome_partitions($S, 0, [], \@result);

if (@result) {
    print "There are ", scalar(@result), " possible solutions.\n";
    my $index = 1;
    for my $partition (@result) {
        print "$index) ", join(', ', @$partition), "\n";
        $index++;
    }
} else {
    print "-1\n";
}

