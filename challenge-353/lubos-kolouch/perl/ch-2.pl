#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Str);

=pod

=head1 NAME

ch-2.pl - Validate Coupon

=head1 SYNOPSIS

  perl ch-2.pl "A123,electronics,true" "B_456,restaurant,false"
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Validates coupon codes based on these rules:

=over 4

=item * code is non-empty and contains only C<[A-Za-z0-9_]> characters

=item * name is one of: electronics, grocery, pharmacy, restaurant

=item * status is true

=back

Returns a list of booleans indicating validity for each tuple.

=cut

my $CODES_CHECK  = compile( ArrayRef [Str] );
my $NAMES_CHECK  = compile( ArrayRef [Str] );
my $STATUS_CHECK = compile( ArrayRef [Str] );

my %ALLOWED = map { $_ => 1 } qw(electronics grocery pharmacy restaurant);

sub _status_is_true ($value) {
    return 0 if !defined $value;
    my $lc = lc $value;
    return 1 if $lc eq 'true' || $lc eq '1';
    return 0;
}

sub validate_coupon ($codes, $names, $status) {
    ($codes)  = $CODES_CHECK->($codes);
    ($names)  = $NAMES_CHECK->($names);
    ($status) = $STATUS_CHECK->($status);

    die 'Input arrays must have the same length'
      if @$codes != @$names || @$codes != @$status;

    my @out;
    for my $i ( 0 .. $#$codes ) {
        my $code_ok   = defined $codes->[$i] && $codes->[$i] ne '' && $codes->[$i] =~ /^\w+$/;
        my $name_ok   = defined $names->[$i] && exists $ALLOWED{ $names->[$i] };
        my $status_ok = _status_is_true( $status->[$i] );
        push @out, ( $code_ok && $name_ok && $status_ok ) ? 1 : 0;
    }

    return \@out;
}

sub _as_bool_words ($bits) {
    return [ map { $_ ? 'true' : 'false' } @$bits ];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my ( @codes, @names, @status );
    for my $triple (@args) {
        my ( $code, $name, $st ) = split /,/, $triple, 3;
        push @codes,  $code  // '';
        push @names,  $name  // '';
        push @status, $st    // '';
    }

    my $result = validate_coupon( \@codes, \@names, \@status );
    say 'Output: (' . join( ', ', @{ _as_bool_words($result) } ) . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label  => 'Example 1',
            codes  => [ qw(A123 B_456 C789 D@1 E123) ],
            names  => [ qw(electronics restaurant electronics pharmacy grocery) ],
            status => [ qw(true false true true true) ],
            expected => [ 1, 0, 1, 0, 1 ],
        },
        {
            label  => 'Example 2',
            codes  => [ qw(Z_9 AB_12 G01 X99 test) ],
            names  => [ qw(pharmacy electronics grocery electronics unknown) ],
            status => [ qw(true true false true true) ],
            expected => [ 1, 1, 0, 1, 0 ],
        },
        {
            label  => 'Example 3',
            codes  => [ '_123', '123', '', 'Coupon_A', 'Alpha' ],
            names  => [ qw(restaurant electronics electronics pharmacy grocery) ],
            status => [ qw(true true false true true) ],
            expected => [ 1, 1, 0, 1, 1 ],
        },
        {
            label  => 'Example 4',
            codes  => [ qw(ITEM_1 ITEM_2 ITEM_3 ITEM_4) ],
            names  => [ qw(electronics electronics grocery grocery) ],
            status => [ qw(true true true true) ],
            expected => [ 1, 1, 1, 1 ],
        },
        {
            label  => 'Example 5',
            codes  => [ qw(CAFE_X ELEC_100 FOOD_1 DRUG_A ELEC_99) ],
            names  => [ qw(restaurant electronics grocery pharmacy electronics) ],
            status => [ qw(true true true true false) ],
            expected => [ 1, 1, 1, 1, 0 ],
        },
    );

    Test::More::plan( tests => scalar @cases );

    for my $case (@cases) {
        my $got = validate_coupon( $case->{codes}, $case->{names}, $case->{status} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 validate_coupon($codes, $names, $status)

Accepts three array references and returns an array reference of booleans (1/0)
indicating which entries satisfy the validation rules.

=cut
