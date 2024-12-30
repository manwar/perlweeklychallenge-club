use strict;
use Getopt::Long;

my $str_opt;
my @str;
my $verbose;

my $tokens = {
    "0" => {
        "left" => 0,
        "str_count" => sub { my $s = shift; return $s =~ tr/0//; }
    },
    "1" => {
        "left" => 0,
        "str_count" => sub { my $s = shift; return $s =~ tr/1//; }
    }
};

GetOptions (
    "x=i" => \$tokens->{0}->{left},
    "y=i" => \$tokens->{1}->{left},
    "str=s" => \$str_opt,
    "verbose" => \$verbose
) or die("Usage: $0 -x x -y y --str commaseparated_stringlist [ --verbose ]");
validate_opts();

@str = sort sort_str @str;
my @subset;

foreach my $s (@str) {
    last if ($tokens->{0}->{left} == 0 && $tokens->{1}->{left} == 0) or (length($s) > $tokens->{0}->{left} + $tokens->{1}->{left});
    my %token_counts;

    print "Checking string $s\n" if $verbose;
    for my $t (sort(keys(%$tokens))) {
        print " > '$t' tokens left: $tokens->{$t}->{left}\n" if $verbose;
        $token_counts{$t} = $tokens->{$t}->{str_count}->($s);
    }

    if ($token_counts{0} <= $tokens->{0}->{left} && $token_counts{1} <= $tokens->{1}->{left}) {
        print " < Adding string $s to subset\n" if $verbose;
        push @subset, $s;
        $tokens->{0}->{left} -= $token_counts{0};
        $tokens->{1}->{left} -= $token_counts{1};
    }
}

print "Subset: " . join(", ", @subset) . "\n" if $verbose;
print ($#subset + 1). "\n";

sub sort_str($$) {
    my $a = shift;
    my $b = shift;

    if (length($a) < length($b)) {
        return -1;
    } elsif (length($a) > length($b)) {
        return 1;
    }
    return $a cmp $b;
}


sub validate_opts {
    die "x must be a number > 0" unless $tokens->{0}->{left};
    die "y must be a number > 0" unless $tokens->{1}->{left};
    die "str must be defined" if length($str_opt) < 1;

    foreach my $s (split /,/,  $str_opt) {
        die "$s value of str is not valid!" if $s =~ /[^01]/;
        push @str, $s;
    }
}
