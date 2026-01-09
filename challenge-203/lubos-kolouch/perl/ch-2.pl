#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use File::Path qw(make_path);
use File::Spec;
use File::Temp qw(tempdir);
use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-2.pl - Copy Directory

=head1 SYNOPSIS

  perl ch-2.pl /source/path /target/path
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Recursively copy the directory structure from C<$source> into C<$target>,
excluding files (i.e. only directories are created).

=cut

my $ARGS_CHECK = compile( Str, Str );

sub copy_directory ($source, $target) {
    ( $source, $target ) = $ARGS_CHECK->( $source, $target );

    die "Source is not a directory: $source" if !-d $source;
    make_path($target) if !-d $target;

    opendir my $dh, $source or die "Can't open $source: $!";
    while ( my $entry = readdir $dh ) {
        next if $entry eq '.' || $entry eq '..';
        my $src_path = File::Spec->catfile( $source, $entry );
        next if !-d $src_path;

        my $dst_path = File::Spec->catfile( $target, $entry );
        make_path($dst_path) if !-d $dst_path;
        copy_directory( $src_path, $dst_path );
    }
    closedir $dh;

    return 1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <source> <target>\n" if @args != 2;
    my ( $source, $target ) = @args;
    copy_directory( $source, $target );
    say "Copied directories from $source to $target";
}

sub _touch ($path) {
    open my $fh, '>', $path or die "Can't write $path: $!";
    print {$fh} "x\n";
    close $fh;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my $tmp = tempdir( CLEANUP => 1 );
    my $source = File::Spec->catdir( $tmp, 'a', 'b', 'c' );
    my $target = File::Spec->catdir( $tmp, 'x', 'y' );

    make_path( File::Spec->catdir( $source, '1' ) );
    make_path( File::Spec->catdir( $source, '2' ) );
    make_path( File::Spec->catdir( $source, '3' ) );
    make_path( File::Spec->catdir( $source, '4' ) );
    make_path( File::Spec->catdir( $source, '5' ) );

    _touch( File::Spec->catfile( $source, '1', '1.txt' ) );
    _touch( File::Spec->catfile( $source, '2', '2.txt' ) );
    _touch( File::Spec->catfile( $source, '3', '3.txt' ) );
    _touch( File::Spec->catfile( $source, '5', '5.txt' ) );

    make_path($target);

    copy_directory( $source, $target );

    my @expected_dirs = qw(1 2 3 4 5);
    Test::More::plan( tests => scalar(@expected_dirs) + 4 );
    for my $d (@expected_dirs) {
        Test::More::ok( -d File::Spec->catdir( $target, $d ), "dir $d exists" );
    }

    Test::More::ok( !-e File::Spec->catfile( $target, '1', '1.txt' ), 'no files copied (1.txt)' );
    Test::More::ok( !-e File::Spec->catfile( $target, '2', '2.txt' ), 'no files copied (2.txt)' );
    Test::More::ok( !-e File::Spec->catfile( $target, '3', '3.txt' ), 'no files copied (3.txt)' );
    Test::More::ok( !-e File::Spec->catfile( $target, '5', '5.txt' ), 'no files copied (5.txt)' );
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 copy_directory($source, $target)

Recursively copies only directories from C<$source> into C<$target>.

=cut

