use strict;
use warnings;

my @S1 = (1, 2, 5, 3, 4);
my @S2 = (4, 2, 7, 8, 9);

my @S3;
my @S3_sort;
my @result;

foreach (@S1, @S2) {
    push @S3, $_;
}

@S3_sort = sort { $a <=> $b } @S3;

for(my $i = 0; $i < $#S3_sort; $i++){
    last if $i == $#S3-1;
	if ($S3_sort[$i] == $S3_sort[$i + 1]) {
        push @result, $S3_sort[$i];
    }
}

if (scalar(@result) > 0) {
    print "0 as the given two sets have common member(s)";
    foreach (@result) {
        print " $_";
    }
    print ".\n";
} else {
    print "1 as the given two sets do not have common member.\n";
}