use v6;

sub proc($n) {
    say "Input: $n";
    my @a = (1 .. $n);
    my @o;
    for @a -> $num {
	if $num < 11 {
	    push @o, $num;
	    next;
	}
	my @d = $num.comb;
	my %h;
	for @d -> $dig {
	    %h{$dig}++;
	}
	my $flag = 0;
	for %h.values -> $val {
	    $flag = 1 if $val > 1;
	}
	next if $flag == 1;
	push @o, $num;
    }
    my $out = 0;
    for 0 .. @o.end - 1 -> $i {
	my $diff = @o[$i+1] - @o[$i];
	$out = $diff if $diff > $out;
    }
    say "Output: $out\n";
}

my $int = 20;
proc($int);
$int = 110;
proc($int);
$int = 500;
proc($int);
$int = 2026;
proc($int);
$int = 10000;
proc($int);
