use v5.38;

my $alph = "abcdefghijklmnopqrstuvwxyz";

sub proc(@seq) {
    say "Input: @seq";
    my @ind;
    my $loc_of_q;
    for my $i (0 .. $#seq) {
	my $letter = $seq[$i];
	my $index = index($alph, $letter);
	push @ind, $index;
	if ($letter eq "?") {
	    $loc_of_q = $i;
	}
    }
    my @diff;
    for my $i (0 .. $#ind - 1) {
	next if ($ind[$i] == -1 || $ind[$i + 1] == -1);
	my $diff = $ind[$i + 1] - $ind[$i];
	push @diff, $diff;
    }
    my @steps = ($diff[0], $diff[1]);
    @steps = reverse(@steps) if ($loc_of_q == 0 || $loc_of_q == 1);

    my @out;
    if ($loc_of_q == 0) {
	my $index = $ind[1] - $steps[0];
	my $letter = substr $alph, $index, 1;
	push @out, $letter;
	push @out, @seq[1 .. $#seq];
    } else {
	push @out, $seq[0];
	my $ind = $ind[0];
	for my $i (0 .. 3) {
	    $ind += $steps[$i % 2];
	    my $letter = substr $alph, $ind, 1;
	    push @out, $letter;
	}
    }
    say "Output: @out";
}

my @seq = qw(a c ? g i);	# e
proc(@seq);
@seq = qw(a d ? j m);		# g
proc(@seq);
@seq = qw(a e ? m q);		# i
proc(@seq);
@seq = qw(a c f ? k);		# h
proc(@seq);
@seq = qw(b e g ? l);		# j
proc(@seq);
@seq = qw(b e g j ?);		# l
proc(@seq);
@seq = qw(? e g j l);		# b
proc(@seq);
@seq = qw(? c f h k);		# a
proc(@seq);
@seq = qw(? a b c d);		# z
proc(@seq);
@seq = qw(z a b c ?);		# d
proc(@seq);
