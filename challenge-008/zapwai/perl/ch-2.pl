use v5.30;
sub center {
    my @list = @_;
    my $long = 0;
    foreach (@list) {
	$long = length $_ if (length $_ > $long);
    }
    my $cnt;
    do {
	$cnt = 0;    
	foreach (@list) {
	    if (length $_ < $long) {
		$cnt++;
		add_space($_);
	    }
	}
    } while ($cnt != 0);
    return \@list;
}

sub add_space { $_[0] = " $_[0] "; }

my $ref = center("This", "is", "a test of the", "center function");
say foreach (@$ref);
