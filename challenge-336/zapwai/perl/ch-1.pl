use v5.38;

sub proc(@ints) {
    say "Input: @ints";
    my %f;
    $f{$_}++ for (@ints);
    my $o;
    for my $k (keys %f) {
	if ($f{$k} == 1) {
	    $o = "false";
	} 
    }
    $o = "true" unless ($o);
    say "Output: $o"
}

my @ints = (1,1,2,2,2,2);
proc(@ints);
@ints = (1,1,1,2,2,2,3,3);
proc(@ints);
@ints = (5,5,5,5,5,5,7,7,7,7,7,7);
proc(@ints);
@ints = (1,2,3,4);
proc(@ints);
@ints = (8,8,9,9,10,10,11,11);
proc(@ints);
