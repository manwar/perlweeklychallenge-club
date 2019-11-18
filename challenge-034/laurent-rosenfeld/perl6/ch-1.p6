use v6;

my @array = 0..10;
my $count = 0;
my %hash  = map {$_ => ++$count}, 'a'..'j';

say "Array slice :  @array[3..7]";
say "Hash slice 1: ", join ' ', %hash{'b', 'd', 'c'};
say "Hash slice 2: ", join ' ', %hash{'b'..'d'};
say "Hash slice 3: ", join ' ', %hash<b c d>;

# Array slice a l-value
my @new-array = (1, 2);
@new-array[2, 3] = @array[6, 7];
say "New array: ", @new-array;
# Hash slice as l-value:
my @keys = qw/c d e/;
my %new-hash;
%new-hash{@keys} = %hash{@keys};
say "New hash: ", %new-hash;
