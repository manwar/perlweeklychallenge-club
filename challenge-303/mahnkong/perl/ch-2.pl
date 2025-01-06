package Challenge;

use strict;

sub new {
    my $class = shift;
    my %opts  = @_;
    my $self = {
        verbose => $opts{verbose} || 0,
    };

    bless $self, $class;
    return $self;
}

sub verbose($) {
    my $self = shift;
    return $self->{verbose};
}

sub print($$) {
    my $self = shift;
    my $text = shift;

    print "$text\n" if $self->verbose;
}

sub run($@) {
    my $self = shift;
    my @ints = @_;

    my %ints;
    my $total_points = 0;

    foreach my $int (@ints) {
        $ints{$int} += 1;
    }

    while (scalar(keys(%ints)) > 0) {
        my $int_to_take = 0;
        my $max_points = 0;
        foreach my $int (keys %ints) {

            my $left = $int - 1;
            my $right = $int + 1;

            my $left_points = $left * $ints{$left};
            my $right_points = $right * $ints{$right};

            my $points = $int * $ints{$int};

            if (! $max_points || ($points > $max_points && $points > $left_points + $right_points)) {
                $int_to_take = $int;
                $max_points = $points;
            }
        }
        $self->print("Taking int '$int_to_take'");
        $total_points += $max_points;
        delete $ints{$int_to_take};
        delete $ints{$int_to_take + 1};
        delete $ints{$int_to_take - 1};
    }

    return $total_points;
}

package main;
use strict;
use Getopt::Long;

my %opts = (ints => "", test => 0, verbose => 0);
my @ints;
main();

sub main {
    GetOptions (
        "ints=s" => \$opts{ints},
        "test" => \$opts{test},
        "verbose" => \$opts{verbose}
    ) or die("Usage: $0 [ --verbose --test ]");

    unless ($opts{test}) {
        validate_opts();

        my $challenge = new Challenge(%opts);
        print $challenge->run(@ints) . "\n";
    } else {
        test();
    }
}

sub validate_opts {
    delete $opts{test};
    die "ints must be defined (--ints 1,4,6,9)" if length($opts{ints}) < 1;

    foreach my $i (split /,/,  $opts{ints}) {
        die "$i value of int is not valid!" if $i =~ /\D/;
        push @ints, $i;
    }
}

sub test() {
    require Test::More; import Test::More 'no_plan';

    my @example1_input = (3, 4, 2);
    my $c1 = new Challenge(verbose => 1);
    is($c1->run(@example1_input), 6, "Example 1");

    my @example2_input = (2, 2, 3, 3, 3, 4);
    my $c2 = new Challenge(verbose => 1);
    is($c2->run(@example2_input), 9, "Example 2");

    my @example3_input = (2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4);
    my $c3 = new Challenge(verbose => 1);
    is($c3->run(@example3_input), 20, "Example 2");

}

1;
