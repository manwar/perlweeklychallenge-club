#!/usr/bin/env perl
use utf8;
use open ':std', ':encoding(UTF-8)';
use strict; use warnings;
use Getopt::Long;
use Pod::Usage;

BEGIN {
    $::debugging = 0;
    $::reading_data_from_stdin = 0;
    my $help = 0;

    GetOptions( "debug" => \$::debugging,
                "stdin" => \$::reading_data_from_stdin,
                "help"  =>  \$help,
        ) or pod2usage(2);

    pod2usage( -exitval => 0, -verbose => 2 ) if $help;

    our $dprint = sub( @ ) {
        ++$|;
        print "[DEBUG] ",@_;
    };

    *::dprint = $::debugging ? $dprint : sub {};
}

package linked_list;
use Scalar::Util qw(blessed refaddr weaken);
#use namespace::clean;

sub new {
    my $class = shift;
    my $obj   = {};
    $obj->{beg_itr_} = linked_list::iterator->new();
    return bless $obj, ( blessed $class || $class );
}

sub DESTROY {
    my $itr = $_[0]->itr;
    {
        my $rubbish = $itr->pop_back;
        if ( defined $rubbish ) {
            ::dprint "removing: " . $rubbish.$/;
            undef $rubbish;
            redo;
        }

    }

    ::dprint "and remvoing: " .$_[0]->{beg_itr_}.$/;
    undef $_[0]->{beg_itr_};
}

sub itr   { $_[0]->{beg_itr_} }

sub count {
    my $itr = $_[0]->itr;

    my $count = 0;
    while ( defined $itr ) {
        ++$count;
        $itr = $itr->next_itr;
    }
    $count;
}

#sub last_itr {  # not used in this case
#    my $itr = $_[0]->itr;
#    return undef unless defined $itr;
#    while ( defined $itr->next_itr ) {
#        $itr = $itr->next_itr;
#    }
#    return $itr;
#}

package linked_list::iterator;
use Scalar::Util qw(blessed refaddr weaken isweak);

sub new {
    my $class = shift;
    my $value  = shift;
    my $obj   = [ $value, undef ];

    weaken( $obj->[0] ) if refaddr( $obj->[0] );
    bless $obj, ( blessed $class || $class );
}

sub next_itr   () { $_[0]->[1]; }
sub value      () { $_[0]->[0]; }

sub push_back_value ( $ ) {
    if ( not defined $_[0]->[0] and not defined $_[0]->[1] ) {
        # first iterator
        $_[0]->[0] = $_[1];
        weaken( $_[0]->[0] ) if refaddr ( $_[0]->[0] );
        return 1;
    }

    my $new = linked_list::iterator->new( $_[1] );
    my $nxt = $_[0]->[1]; # $_[0]->next_itr
    $_[0]->[1] = $new;
    $new->[1]  = $nxt;
    1;
}

sub push_back ( $ ) {
    my $friend_class = blessed( $_[1] );
    if ( not defined $friend_class
         or
         not $friend_class->isa( __PACKAGE__ ) ) {
        ::dprint "friend is not a valid iterator\n";
        return 0;
    }
    if ( blessed $_[1]->[1] ) {
        ::dprint "friend already has another friend: use poped iterator only";
        return 0;
    }
    $_[1]->[1] = $_[0]->[1];
    $_[0]->[1] = $_[1];
    return 1;
}

sub pop_back  () {
    if ( not defined $_[0]->[1] ) {
        return undef;
    }
    my $togo = $_[0]->[1];
    $_[0]->[1] = $togo->[1];
    $togo->[1] = undef;
    return $togo;
}

sub DESTROY {
    ::dprint "$_[0]: destroyed!!!\n";
}

package main;

our $sep_str;
sub separator () { $main::sep_str || " → " }

sub print_all_values ($) {
    my $itr = shift;
    print $itr->value;
    while ( $itr = $itr->next_itr ) {
        print separator.$itr->value;
    }
    print "\n";
}

# instruction is not clear about how to give the list
# so I copied from the website and modfied.
my $example_str = "1  →  2 →  3 →  4 →  5 →  6 →  7";
my $input = "";

if ( $::reading_data_from_stdin ) {
    print STDERR "Default: $example_str\n".
        "please input a linked list like above".
        " or press <enter> to use default values..\n".
        "Input: ";
    $input = <STDIN>;
    chomp $input;
}
elsif ( $input eq "" or not $::reading_data_from_stdin ) {
    print STDERR "Using list: $example_str\n";
    $input = $example_str;
}

# finding separator
my @words = split /\b/, $input;
my %words_score;

for my $w ( @words ) {
    $w =~ s/\s+/ /g; # remove excess spaces ...
    if ( index( $w, '->' ) > 0 or index( $w, '→' ) > 0 ) {
        $words_score{$w} += 5;
    } else {
        ++$words_score{$w};
    }
}

my $max_score = 0;
for my $k ( keys %words_score ) {
    if ( $words_score{$k} > $max_score ) {
        $max_score = $words_score{$k};
        $sep_str = $k;
    }
}

my @given = split( /\s*$sep_str\s*/, $example_str );

my $L = linked_list->new();
my $itr = $L->itr;

for my $value ( @given ) {
    $itr->push_back_value( $value );
    $itr = $itr->next_itr || $L->itr; # ugly
}

$itr = $L->itr;

::dprint "Using Input:\n";
print_all_values( $itr ) if $::debugging;

my $count = $L->count;
::dprint "count of list: $count\n";


my $pair_left_num  = 1;
my $pair_left_pos  = 0;

my $l_itr = $L->itr;

for ( my $round = int( $count / 2 ); $round > 0; --$round ) {
    my $r2_itr = $l_itr; # 2nd last iterator

    my $n_repeat = $count - 1 - $pair_left_pos;
    ::dprint "from: $pair_left_pos, go next $n_repeat time(s) to find 2nd last iterator.\n";
    while ( --$n_repeat > 0 ) {  # find (N-1)th node
         $r2_itr = $r2_itr->next_itr;
    }
    my $r_itr = $r2_itr->pop_back;
    ::dprint "right of the pair has value of: ".$r_itr->value.$/;
    $l_itr->push_back( $r_itr );

    $l_itr = $l_itr->next_itr->next_itr;

    ++$pair_left_num;
    $pair_left_pos += 2;
}

undef $l_itr;
$itr = $L->itr;

print STDERR "Output:\n";
print_all_values( $itr );


__END__
=encoding utf8
=head1 NAME

CHALLENGE 68 Task #2 - Reorder List

=head1 SYNOPSIS

perl ch-2.pl [--debug] [--stdin]

  Options:
    --stdin:    read data from the stdin,
                not from internal example
    --rows:     number of rows of matrix    [ > 2; default: 3 ]
    --columns:  number of columns of matrix [ > 2; default: 3 ]

=head1 DESCRIPTION

  Task:

    You are given a singly linked list $L as below:

    L0 →  L1 →  … →  Ln-1 →  Ln

    Write a script to reorder list as below:

    L0 →  Ln →  L1 →  Ln-1 →  L2 →  Ln-2 → ...

  My Solution:
    I simply follow the rule in this case because I assume that the starting
    point of this challenge when we are "only" given a real linked list.

    Steps are also straight foward.

      1. I made poor single-linked list class and save the data in the list
      2. with 'left' iterators I follow L0, L1 ...
      3. with 'right' iterators  I follow Ln, Ln-1 ...

    Pros:
      I could save memory a little bit not by making another array
    Cons:
      If the list is too long, it could be slow
    Comment:
      I think we can impove it by using circular linked list.

=cut
