#!/usr/bin/env perl
#
# perl/ch-2.pl - Lucky Winner
#
# Ryan Thompson <rjt@cpan.org>

use 5.016;
use warnings;
use strict;
use utf8;
no warnings 'uninitialized';

use List::Util qw/max min sum/;
use Getopt::Long;
use Pod::Usage;

# Magic numbers
use constant { PLAYER0 => 0, PLAYER1 => 1,    LEFT => 0, RIGHT => 1 };

# Get commandline options
my %o = ( coins => 8, maxcoin => 200, help => sub { pod2usage( verbose => 2 ) } );
GetOptions(\%o, qw< verbose! count=i maxcoin=i coins=i human=s seed=i help >)
    or pod2usage( -exit => 2, -verbose => 0 );

sub verbose($;@) { printf shift.$/, @_ if $o{verbose} } # Verbose ouput

srand $o{seed} if $o{seed};
my %alg = get_algorithms();
my @alg = @ARGV;
@alg = sort keys %alg if @alg == 0;
die "Unknown algorithm $_\n" for grep { not exists $alg{$_} } @alg;

# If we're in human v CPU mode, we want different defaults
if ($o{human}) {
    die "Unknown algorithm $o{human}" if not exists $alg{ $o{human} };
    $alg{human} = \&human; # Only valid when --human is specified
    @alg = ('human', $o{human});

    $o{verbose} //= 1; # Disable with --noverbose
    $o{count}   //= 1;
} else {
    $o{count}   //= 1000;
}

round_robin(@alg);

#
# Helpers
#

# Pit all algorithms against each other in a round robin format
sub round_robin {
    my @alg = @_;

    my %wins;
    printf "%13s v %-13s | %6s - %-6s\n", qw<Player0 Player1 Wins0 Wins1>;
    say '-' x 50;
    for my $idx0 (0..$#alg) {
        for my $idx1 ($idx0+1..$#alg) {
            my ($a0, $a1) = map { $alg[$_] } $idx0, $idx1;
            my ($s0, $s1) = run_winner($a0, $a1);
            my $a0_win = $s0 > $s1 ? '(W)' : '  ';
            my $a1_win = $s1 > $s0 ? '(W)' : '  ';
            printf "%3s%10s v %-10s%3s | %6d - %-6d\n", $a0_win, $a0, $a1, $a1_win, $s0, $s1;
            $wins{$a0} += $s0;
            $wins{$a1} += $s1;
        }
    }

    say "\nLeaderboard:";
    for (sort { $wins{$b} <=> $wins{$a} } keys %wins) {
        printf "%11s: %7d win%s\n", $_, $wins{$_}, $wins{$_} == 1 ? '' : 's';
    }
}

# Run two algorithms against each other count times, and return win counts
# Note that it runs through count twice, for PLAYER0 and PLAYER1 starts.
#   a0      => name of player 0 algorithm (see %algorithms)
#   a1      => name of player 1 algorithm
sub run_winner {
    my ($a0, $a1) = @_;
    my @a = map { $alg{$_} } @_;

    my $a0_wins = 0;
    for my $game (1..$o{count}) {
        for my $start (PLAYER0, PLAYER1) {
            my @coins = map { 1 + int rand $o{maxcoin} } 1..$o{coins};

            my $pp = coin_pp(@coins);
            verbose '-' x 78;
            verbose "Game#%d/%d, player$start goes first", $game, $o{count};
            my $player = $start;
            my @score;

            while (@coins) {
                my $lr = $a[$player]->(@coins);
                my $val = $lr == LEFT ? shift @coins : pop @coins;
                $score[$player] += $val;
                verbose "%10s: %50s | %10s: %4d, %10s: %4d",
                    $_[$player], $pp->($lr, $val, @coins),
                    $_[0], $score[0], $_[1], $score[1];
                $player ^= 1;
            }

            my $winner = $score[PLAYER0] > $score[PLAYER1] ? 0 : 1;
            $a0_wins++ if 0 == $winner;
            verbose "Player%d wins!", $winner;
        }
    }

    $a0_wins, $o{count}*2 - $a0_wins;
    # / ($o{count}*2), 1 - ($a0_wins / ($o{count}*2))
}

# Pretty print coins remaining and current move, aligned to make it easier
# to see what is going on. Returns a sub to use in the current loop.
sub coin_pp {
    my @coins = @_;

    my $str = " @coins ";
    my $len = length $str;

    sub {
        my ($lr, $val) = @_;
        $str =~ s/(\[\d+\])/' ' x length $1/e; # Erase last move
        $str =~ s/\s(\d+)\s/[$1]/ if $lr == LEFT;
        $str =~ s/\s(\d+)\s(\s*)$/[$1]$2/ if $lr == RIGHT;
        $str;
    }
}

#
# Algorithms
#

# Each sub here takes @coins as an argument and returns 0 for left and 1 for
# right, meaning it wants to remove the left or right coin.
sub get_algorithms {
    (
        bozo    => sub { rand > 0.5 },
        worst   => sub { $_[0] > $_[-1] },
        greedy  => sub { $_[0] < $_[-1] },
        ahead1  => \&ahead1,
        ahead3  => ahead(3),
        ahead5  => ahead(5),
    );
}

# Human player. Prompts for input.
sub human {
    local $| = 1; # Unbuffered output
    do {
        printf "< @_ > | Your move [lrq]: ";
        $_ = lc(<STDIN>);
        chomp;
    } while (!/^[lrq]$/);
    die "Quitter!\n" if $_ eq 'q';

    return $_ eq 'l' ? LEFT : RIGHT;
}

# Looks one move ahead and maximizes own results
sub ahead1 {
    # Base case. Can't do better than this.
    return $_[0] < $_[-1] if @_ <= 3;

    my $lr = LEFT;
    my %best = (lr => undef, score => -$o{maxcoin});

    do {
        my $score = $_[0];
        $score -= max $_[1], $_[-1];

        %best = (lr => $lr, score => $score) if $score > $best{score};

        # Repeat for RIGHT
        @_ = reverse @_;
    } while ($lr ^= 1);

    $best{lr};
}

# Look ahead n moves
sub ahead {
    my $n = shift;

    sub {
        my $ahead = sub {
            my ($depth, $us, $lr, @coins) = @_;
            my $val = $us * ($lr == LEFT ? shift @coins : pop @coins);
            return $val if !$depth or @coins == 0;

            my $f = $us == 1 ? \&min : \&max;
            $val + $f->(
                map { __SUB__->($depth-1, -$us, $_, @coins) } LEFT, RIGHT
            );
        };

        $ahead->($n, 1, LEFT,  @_) > 
        $ahead->($n, 1, RIGHT, @_) ? LEFT : RIGHT;
    };
}

__END__
=head1 NAME

ch-2.pl - Lucky Winner Simulator 9000

=head1 SYNOPSIS

    ch-2.pl [options] [algorithm1 algorithm2 ...]
    ch-2.pl --human=<cpu_algorithm>
    ch-2.pl --help

=head1 OPTIONS

 --count=<iter>     Play <iter> games                   Default: 1000
 --coins=<N>        Every game uses <N> coins           Default: 8
 --maxcoin=<N>      Maximum coin value                  Default: 200
 --help             Full help page
 --human=<cpu_alg>  Human vs CPU, CPU uses <cpu_alg>
 --seed=<N>         Use specific random number seed (integer)
 --verbose          Enable extra output
 --noverbose        Disable extra output

=head1 ALGORITHMS

=over 16

=item   human

Human input. Only available with C<--human> option.

=item   bozo

Real stupid algorithm; chooses left or right randomly.

=item   worst

Somehow even stupider. Always picks lowest option.

=item   greedy

Greedy algorithm. Always picks highest option, but doesn't look ahead.

=item   ahead1

=item   ahead3

=item   ahead5

Looks ahead B<1>, B<3>, or B<5> turns, and picks the option that maximizes
(B<my_score> - B<their_score>)

=back

=head1 AUTHOR

Ryan Thompson <rjt@cpan.org>
