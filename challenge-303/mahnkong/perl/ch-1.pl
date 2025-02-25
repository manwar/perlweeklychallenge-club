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

    my @result;

    for (my $i = 0; $i <= $#ints; $i++) {
        next if $ints[$i] == 0;
        for (my $j = 0; $j <= $#ints; $j++) {
            next if $i == $j;
            for (my $k = 0; $k <= $#ints; $k++) {
                next if $i == $k || $j == $k || $ints[$k] % 2;
                push @result, "$ints[$i]$ints[$j]$ints[$k]" unless grep /^$ints[$i]$ints[$j]$ints[$k]$/, @result;
            }
        }
    }

    return sort { $a <=> $b } @result;
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
        my @result = $challenge->run(@ints);

        print "(" . join(", ", @result) . ")\n";
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

    die "At least 3 ints must be provided" if $#ints < 2;
}

sub test() {
    require Test::More; import Test::More 'no_plan';

    my @example1_input = (2, 1, 3, 0);
    my @example1_output = (102, 120, 130, 132, 210, 230, 302, 310, 312, 320);
    my $c1 = new Challenge(verbose => 1);
    my @result = $c1->run(@example1_input);
    is_deeply(\@example1_output, \@result, "Example 1");

    my @example2_input = (2, 2, 8, 8, 2);
    my @example2_output = (222, 228, 282, 288, 822, 828, 882);
    my $c2 = new Challenge(verbose => 1);
    my @result = $c2->run(@example2_input);
    is_deeply(\@example2_output, \@result, "Example 2");
}

1;
