use v5.30;
no warnings;
my @arr1 = (1,2,3);
my @arr2 = (2,4,6);

@arr1 = (1,2,3,3);
@arr2 = (1,1,2,2);

say "\@arr1 = @arr1";
say "\@arr2 = @arr2";

my @diff1;
my @diff2;

for my $v (@arr1) {
    push @diff1, $v unless ($v ~~ @arr2);
}

for my $v (@arr2) {
    push @diff2, $v unless ($v ~~ @arr1);
}

my %d1;
my %d2;

$d1{$_} = 1 for (@diff1);
$d2{$_} = 1 for (@diff2);

my @d1 = keys %d1;
my @d2 = keys %d2;

say "Output: (" . join(", ", @d1) . ")";
say "\t(" . join(", ", @d2) . ")";
