use v5.38;
my $items1c = [ [1,1], [2,1], [3,2] ];
my $items2c = [ [2,2], [1,3] ];
my $items1a = [ [1,2], [2,3], [1,3], [3,2] ];
my $items2a = [ [3,1], [1,3] ];
my $items1b = [ [1,1], [2,2], [3,3] ];
my $items2b = [ [2,3], [2,4] ];
proc($items1c, $items2c);
proc($items1a, $items2a);
proc($items1b, $items2b);

sub print_input($items1, $items2) {
    print "Input: ";
    print "\@items1: ";
    print "(".join(", ", @$_).") " for (@$items1);
    print "\@items2: ";
    print "(".join(", ", @$_).") " for (@$items2);
    print "\n";
}

sub print_output($href) {
    my %h = %$href;
    print "Output: ";
    foreach (sort { $a <=> $b } keys %h) { 
	print "[$_, $h{$_}] ";
    }
    print "\n";
}

sub proc($items1, $items2) {
    print_input($items1, $items2);
    my %h;
    foreach my $i (@$items1) {
	$h{$$i[0]} += $$i[1];
    }
    foreach my $i (@$items2) {
	$h{$$i[0]} += $$i[1];
    }
    print_output(\%h);
}
