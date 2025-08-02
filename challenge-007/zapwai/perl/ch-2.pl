use v5.38;
use List::MoreUtils qw(uniq);

my @l1 = ("pour", "cold", "peer", "knife", "prince");
my @l2 = ("made", "warm", "norm", "dance", "prance");
my %h = map { $l1[$_], $l2[$_] } (0 .. $#l1);
proc($_,$h{$_}) foreach (keys %h);

sub quit() {print "()\n"; 1}

sub proc($input1, $input2) {
    say "Input: $input1 - $input2";
    print "Output: ";

    return quit() unless (length $input1 == length $input2);

    open my $fh, "<", "words";
    my @rows = <$fh>;
    close $fh;

    return quit() unless grep { /^$input1$/ } @rows;
    return quit() unless grep { /^$input2$/ } @rows;
    
    my $wordlen = length $input1;
    our @words = grep { /^\w{$wordlen}$/ } @rows;
    chomp @words;

    our @A = ([$input1]);
    our @B = ([$input2]);
    my $lvl = 0;
    my $limit = 10;		# (max chain length is 2*limit)
    my @center;
    do {
	my (@anew, @bnew);
	push @anew, @{expand($_)} foreach (@{$A[$lvl]});
	push @bnew, @{expand($_)} foreach (@{$B[$lvl]});
	@anew = uniq @anew;
	@bnew = uniq @bnew;
	push @A, \@anew;
	@center = check($lvl + 1, $lvl);
	push @B, \@bnew;
	$lvl++;
    } until (@center or @center = check($lvl, $lvl) or $lvl == $limit);
    
    return quit() if ($lvl == $limit);
    
    my $counter = $lvl - 1;
    my @list = ($center[0]);
    my $x = neighbor($center[0], $A[$counter]);
    my $y = neighbor($center[0], $B[$counter]);
    if ($y) {
	do {
	    unshift @list, $x;
	    push @list, $y;
	    $counter--;
	    $x = neighbor($x, $A[$counter]);
	    $y = neighbor($y, $B[$counter]);
	} until ($counter == 0);
    }
    unshift @list, $x;
    push @list, $y;

    say "@list";

    # returns first neighbor of $word in @$ref
    sub neighbor($word, $ref) {
	for my $w (@$ref) {
	    if (dist($w, $word) == 1) {
		return $w;
	    }
	}
    }

    sub dist($word1, $word2) {
	my @let1 = split "", $word1;
	my @let2 = split "", $word2;
	my $cnt = 0;
	for my $i (0 .. $#let1) {
	    $cnt++ if ($let1[$i] ne $let2[$i]);
	}
	$cnt
    }

    sub check($m, $n) {
	my @ans;
	for my $i (0 .. $m) {
	    for my $j (0 .. $n) {	
		push @ans, intersection($A[$i], $B[$j]);
	    }
	}
	return @ans;
    }

    sub expand($word) {
	my @new;
	for my $i (0 .. (length $word) - 1) {
	    my ($pre, $post) = (substr($word, 0, $i), substr($word, $i+1));
	    foreach (grep { $_ =~ /^$pre.$post$/ } @words) {
		push @new, $_;
	    }
	}
	@new = grep { !($_ eq $word) } @new;
	return \@new;
    }

    sub intersection($r, $s) {
	my @int;
	my @A = @$r;
	my @B = @$s;
	for my $i (0 .. $#A) {
	    for my $j (0 .. $#B) {
		if ($A[$i] eq $B[$j]) {
		    push @int, $A[$i];
		}
	    }
	}
	return @int;
    }

}
