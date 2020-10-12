use strict;
use warnings;
use feature "say";

my $input = "WestSideStory.txt";
open my $IN, "<", $input or die "Unable to open $input $!";
my @in = <$IN>;
chomp @in;
my $str = join " ", @in;
$str =~ s/[."(),]+//g;
$str =~ s/(\'s)||(--)//g;
my %histogram;
$histogram{$_}++ for split /\s+/, $str;
my %summary;
push @{$summary{$histogram{$_}}}, $_ for keys %histogram;
for my $k (sort {$a <=> $b} keys %summary) {
    say "$k ", join " ", sort @{$summary{$k}};
}
