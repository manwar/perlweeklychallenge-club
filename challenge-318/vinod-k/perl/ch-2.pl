use strict;
use warnings;

my @source = (3, 2, 1, 4);
my @target = (1, 2, 3, 4);

if (transform_with_reverse(\@source, \@target)) {
    print "true\n";
} else {
    print "false\n";
}

sub transform_with_reverse {
    my ($src, $tgt) = @_;
    my $n = @$src;

    my $start = 0;
    $start++ while $start < $n && $src->[$start] == $tgt->[$start];

    return 1 if $start == $n;

    my $end = $n - 1;
    $end-- while $end >= 0 && $src->[$end] == $tgt->[$end];

    my @reversed = @$src;
    @reversed[$start..$end] = reverse @reversed[$start..$end];

    if ("@reversed" eq "@$tgt") {
        print "Reverse elements: $start-$end\n";
        return 1;
    }

    return 0;
}
