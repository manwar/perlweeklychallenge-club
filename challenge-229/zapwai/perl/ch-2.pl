use v5.30;
no warnings;
my @array1 = (1, 1, 2, 4);
my @array2 = (2, 4);
my @array3 = (4);
# @array1 = (4,1);
# @array2 = (2, 4);
# @array3 = (1,2);
my %h;
$h{$_}++ for (@array1, @array2, @array3);
my @tot = keys %h;
my @ans;
foreach my $n (@tot) {
    my $cnt = 0;
    $cnt++ if ($n ~~ @array1);
    $cnt++ if ($n ~~ @array2);
    $cnt++ if ($n ~~ @array3);
    push @ans, $n if ($cnt > 1);
}
@ans = sort { $a <=> $b } @ans;
say "Input: \t \@array1 = @array1";
say "\t \@array2 = @array2";
say "\t \@array3 = @array3";
say "Output: @ans";
