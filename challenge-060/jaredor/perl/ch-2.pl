#!/usr/bin/env perl

use v5.012;
use warnings;
use integer;
use Getopt::Long;
use Pod::Usage;
use List::Util qw(uniq any min);

Getopt::Long::Configure( 'bundling_values', 'ignorecase_always',
    'pass_through' );

GetOptions(
    'X=i'     => \( my $X ),
    'Y=i'     => \( my $Y ),
    'help|h!' => \( my $help ),
    'task|t!' => \( my $task )
);

pod2usage(1) if $help;
pod2usage( -exitval => 0, -verbose => 2 ) if $task;

my @errors;
push @errors, "Required --X option must be a positive integer."
  unless defined $X and $X > 0;
push @errors, "Required --Y option must be a positive integer."
  unless defined $Y and $Y > 0;
push @errors, "One or more non-negative numbers must be given."
  unless @ARGV;
pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

my $nmax = $Y - 1;

die "The maximum valid value, $nmax, is too small to be of length $X."
  unless length($nmax) >= $X;

my $nums;
push @{ $nums->{ length $_ } }, $_ for uniq sort { $a <=> $b } @ARGV;

my ( $minv, $maxv ) = ( 10**( $X - 1 ), 10**$X );
$minv = 0 if $X == 1 and any { $_ == 0 } @{ $nums->{1} };

sub get_all_substrs {
    my ( $lim, $len, $nums, $not_first_recursion ) = @_;
    return ( '', ) unless $len;
    my %nums = %{$nums};
    $_ > $len and delete $nums{$_} for keys %nums;
    my $keylen_min = min keys %nums;
    return ( '', ) unless defined $keylen_min;
    my @results;
    for my $numlen ( keys %nums ) {
        my $newlen = $len - $numlen;
        if ($newlen) {
            for my $num ( @{ $nums{$numlen} } ) {
                next unless $not_first_recursion or $num;
                my $beglim = substr( $lim, 0, $numlen );
                my $newlim =
                    $num < $beglim ? '9' x $newlen
                  : $num == $beglim ? substr( $lim, $numlen )
                  :                   undef;
                push @results,
                  map { $num . $_ }
                  get_all_substrs( $newlim, $newlen, \%nums, 1 )
                  if defined $newlim and $newlen >= $keylen_min;
            }
        }
        else {
            push @results, grep { $_ <= $lim } @{ $nums{$numlen} };
        }
    }
    return @results;
}

my @output = sort { $a <=> $b } get_all_substrs( $nmax, $X, $nums );

if (@output) {
    say join ", ", @output;
}
else {
    die "No strings of length $X less than value $Y can be formed.";
}

__END__

=head1 NAME

PWC 059, TASK #2 : Find Numbers

=head1 SYNOPSIS

  ch-2.pl [options] [nonnegint ... ]

  Options:
    --X           length of answer string
    --Y           Upper bound, exclusive, answer string value
    --help        Brief help
    --task        Full description

  Arguments:
    One or more non-negative integers to be used in constructing an answer

=head1 OPTIONS

=over 8

=item B<--X>

The required length of any numerical string produced as result.

=item B<--Y>

The upper numerical bound any result must be less than.

=item B<--help>

Brief help message.

=item B<--task>

Complete description of task and the script's attempt to satisfy it.

=back

=head1 DESCRIPTION

Write a script that accepts list of positive numbers (@L) and two positive numbers $X and $Y.

The script should print all possible numbers made by concatenating the numbers from @L, whose length is exactly $X but value is less than $Y.

=head2 Example

=head3 Input:

  @L = (0, 1, 2, 5);
  $X = 2;
  $Y = 21;

=head3 Output:

  10, 11, 12, 15, 20

=head1 INTERPRETATION

Though the task statement says "list of positive numbers" for input arguments,
the example includes 0 in the list and it is used in constructing an answer.
Accordingly, allow 0 as an argument, changing the requirement to "list of
non-negative numbers." Actually, the script effectively changes the requirement
to "list of non-negative integers" because concatenation with floating point
numbers is probably not desired.

Since the output in the example has "11" as an answer with the only input with a
"1" digit being the number "1" itself, the script is written to allow reuse of
elements.

Because octal numbers are a pain and because the task example doesn't have the
digit 0 as a leading digit, e.g., using 05 as an output result, if 0 is in the
"list of non-negative integers" it is not allowed to be a leading digit, except
for the case where it is the only digit, i.e., 0.
=cut
