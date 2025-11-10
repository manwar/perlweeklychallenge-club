use v5.38;

sub proc($phone) {
    say "Input : $phone";
    my @num;
    for my $c (split '', $phone) {
	push @num, $c unless ($c eq "-" || $c eq " ");
    }
    my $o = "";
    my $post = "";		# last four chars, if necessary
    my $len = scalar @num;
    my @post;			# used only in that case
    if ($len % 3 == 1) {
	for (1 .. 4) {
	    unshift @post, pop @num;
	}
	$post = "$post[0]$post[1]-$post[2]$post[3]";
    }
    for my $i (0 .. $#num) {
	$o .= $num[$i];
	$o .= "-" if ($i % 3 == 2 && $i > 0 && $i < $#num);
    }
    
    print "Output: $o";
    if ($post) {
	print "-" if ($o);
	say "$post";
    } else {
	say "";
    }

}

my $phone = "1-23-45-6";
proc($phone);
$phone = "1234";
proc($phone);
$phone = "12 345-6789";
proc($phone);
$phone = "123 4567";
proc($phone);
$phone = "123 456-78";
proc($phone);
