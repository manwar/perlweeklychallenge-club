package Challenge;

use strict;
use Math::Subsets::List;

sub new {
    my $class = shift;
    my %opts  = @_;
    my $self = {
        verbose => $opts{verbose} || 0,
        tokens => {
           "0" => {
               "amount" => $opts{amount0} || 0,
               "str_count" => sub { my $s = shift; return $s =~ tr/0//; }
           },
           "1" => {
               "amount" => $opts{amount1} || 0,
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
    my $max_subset_size = 0;

    subsets {
        my @subset = @_;

        print "Next subset: (@subset)\n" if $self->{verbose};
        my %set_amounts = (0 => 0, 1 => 0);

        foreach my $s (@subset) {
            print "> Checking string $s\n" if $self->{verbose};
            for my $t (keys(%{$self->{tokens}})) {
                $set_amounts{$t} += $self->{tokens}->{$t}->{str_count}->($s);
            }
        }
        if (scalar(@subset) > $max_subset_size && $set_amounts{0} <= $self->{tokens}->{0}->{amount} && $set_amounts{1} <= $self->{tokens}->{1}->{amount}) {
            $max_subset_size = scalar(@subset);
            print "< New max subset size: $max_subset_size\n" if $self->{verbose};
        }
    } @str;

    return $max_subset_size;
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

    my $challenge = new Challenge(amount0 => $x, amount1 => $y => verbose => $verbose);
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

    my $c1 = new Challenge(amount0 => 5, amount1 => 3, => verbose => 1);
    #is($c1->get_max_subset_size("10", "0001", "111001", "1", "0"), 4, "example 1");

    my $c2 = new Challenge(amount0 => 1, amount1 => 1, => verbose => 1);
    is($c2->get_max_subset_size("10", "1", "0"), 2, "example 2");

    my $c3 = new Challenge(amount0 => 60, amount1 => 68, => verbose => 1);
    is($c3->get_max_subset_size("1000000000000000","1100000000000000","1110000000000000","1111000000000000","1111100000000000","1111110000000000","1111111000000000","1111111100000000","1111111110000000","1111111111000000","1111111111100000","1111111111110000","1111111111111000","1111111111111100","1111111111111110","1111111111111111"), 8, "Example from jo-37");
}

1;
