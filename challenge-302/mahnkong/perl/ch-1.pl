package Challenge;

use strict;

sub new {
    my $class = shift;
    my $opts  = shift;
    my $self = {
        verbose => $opts->{verbose} || 0,
        tokens => {
           "0" => {
               "left" => $opts->{amount0} || 0,
               "str_count" => sub { my $s = shift; return $s =~ tr/0//; }
           },
           "1" => {
               "left" => $opts->{amount1} || 0,
               "str_count" => sub { my $s = shift; return $s =~ tr/1//; }
           }
        }
    };

    bless $self, $class;
    return $self;
}

sub get_max_subset_size($@) {
    my $self = shift;
    my @str = @_;

    my @subset;
    @str = sort sort_str @str;
    foreach my $s (@str) {
        last if ($self->{tokens}->{0}->{left} == 0 && $self->{tokens}->{1}->{left} == 0) or (length($s) > $self->{tokens}->{0}->{left} + $self->{tokens}->{1}->{left});
        my %token_counts;

        print "Checking string $s\n" if $self->{verbose};
        for my $t (sort(keys(%{$self->{tokens}}))) {
            print " > '$t' tokens left: $self->{tokens}->{$t}->{left}\n" if $self->{verbose};
            $token_counts{$t} = $self->{tokens}->{$t}->{str_count}->($s);
        }

        if ($token_counts{0} <= $self->{tokens}->{0}->{left} && $token_counts{1} <= $self->{tokens}->{1}->{left}) {
            print " < Adding string $s to subset\n" if $self->{verbose};
            push @subset, $s;
            $self->{tokens}->{0}->{left} -= $token_counts{0};
            $self->{tokens}->{1}->{left} -= $token_counts{1};
        }
    }
    print "Subset: " . join(", ", @subset) . "\n" if $self->{verbose};
    return $#subset + 1;
}

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

package main;
use strict;
use Getopt::Long;

my $x;
my $y;
my @str;
my $test;
my $str_opt;
my $verbose;

GetOptions (
    "x=i" => \$x,
    "y=i" => \$y,
    "str=s" => \$str_opt,
    "test" => \$test,
    "verbose" => \$verbose
) or die("Usage: $0 -x x -y y --str commaseparated_stringlist [ --verbose ]");

unless ($test) {
    validate_opts();

    my $challenge = new Challenge({amount0 => $x, amount1 => $y => verbose => $verbose});
    my $max_subset_size = $challenge->get_max_subset_size(@str);
    print "$max_subset_size\n";
} else {
    test();
}

sub validate_opts {
    die "x must be a number > 0" unless $x;
    die "y must be a number > 0" unless $y;
    die "str must be defined" if length($str_opt) < 1;

    foreach my $s (split /,/,  $str_opt) {
        die "$s value of str is not valid!" if $s =~ /[^01]/;
        die "All strings must be unique!" if (grep(/^$s$/,@str));
        push @str, $s;
    }
}

sub test() {
    require Test::More; import Test::More 'no_plan';

    my $c1 = new Challenge({amount0 => 5, amount1 => 3, => verbose => 1});
    is($c1->get_max_subset_size("10", "0001", "111001", "1", "0"), 4, "example 1");

    my $c2 = new Challenge({amount0 => 1, amount1 => 1, => verbose => 1});
    is($c2->get_max_subset_size("10", "1", "0"), 2, "example 2");
}

1;
