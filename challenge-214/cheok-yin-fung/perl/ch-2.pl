# The Weekly Challenge 214
# Task 2 Collect Points
# a slow but workable method
use v5.30.0;
use warnings;
use List::Util qw/max/;

my %s;
my %n;
my %cnt;
my %end;

sub cp {
    my @numbers = @_;
    $n{""} = [@numbers];
    $s{""} = 0;
    my @to_be_calc = ("");
    while (scalar @to_be_calc != 0) {
        nxt_stage($_) for @to_be_calc;
        @to_be_calc = grep {!$cnt{$_} && !$end{$_}} keys %n;
    }
    my @cand = grep {$end{$_}} keys %n;
    my $ans = max map {$s{$_}} @cand;
    return $ans;
}

sub nxt_stage {
    my $inp = $_[0];
    my $pre_rmseq = $inp;
    my @numbers = $n{$inp}->@*;
    my $pre_score = $s{$inp};
    $cnt{$inp} = 1;
    for my $i (0..$#numbers) {
        my ($rmseq, $sc, @ns)
        = removal_and_score([@numbers], $i, $pre_rmseq, $pre_score);
        $s{$rmseq} = $sc;
        $n{$rmseq} = [@ns];
        $end{$rmseq} = (scalar @ns == 0) ? 1 : 0;
    }
}

sub removal_and_score {
    my @numbers = $_[0]->@*;
    my $i = $_[1];
    my $pre_rmseq = $_[2];
    my $pre_score = $_[3];
    my $si = 0;
    until ($si > $i || $numbers[$i] != $numbers[$i-$si]) {
        $si++;
    }
    $si--;
    my $ti = 0;
    until ($i+$ti > $#numbers || $numbers[$i] != $numbers[$i+$ti]) {
        $ti++;
    } 
    $ti--;
    my $N = $ti+$si+1;
    my $rmseq = ($pre_rmseq ? $pre_rmseq . "," : "") . $i;
    my $score = $pre_score + $N*$N;
    splice(@numbers, $i-$si, $ti+$si+1);
    return ($rmseq, $score, @numbers);
}

say cp(2,4,3,3,3,4,5,4,2);  # 23
