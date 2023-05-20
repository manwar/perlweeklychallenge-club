#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       The Test Data Extraction Machine (tm).
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
no warnings 'experimental::signatures';

package TestExtractor;
use Exporter 'import';
our @EXPORT = qw( run_tests $verbose %options vsay pp );

use Data::Dump qw( pp );
use Getopt::Long;
use Cwd qw( abs_path );
use File::Basename;
use Test2::V0;
no warnings 'experimental::signatures';

our ( $verbose, %options );
sub vsay { say @_ if $verbose };

sub run_tests {

    $| = 1;

    GetOptions(
        "v|verbose!" => \$verbose,
    ) or do { say "usage!"; exit 2 };

    my $dir = dirname abs_path $0;
    my ( $challenge, $task ) =
        abs_path( $0 ) =~ m{challenge-(\d+) .* (\d+)[^[/\\]*$}x;
    unless ( $challenge && $task ) {
        say STDERR "ERROR: ",
            "Cannot determine challenge number or task number. Exiting.";
        exit 1;
    }

    my $local_tests;
    ( undef, $local_tests ) = read_task( *::DATA )
	if fileno *::DATA;

    my ( $task_title, $task_description ) =
        read_task( "$dir/challenge-${challenge}.txt", $task );
    vsay $task_title;

    my @tests = (
        $local_tests      ? extract_tests( $local_tests )      : (),
	$task_description ? extract_tests( $task_description ) : (),
    );
    vsay pp( @tests );

    ( my $sub_name = lc $task_title ) =~ s/\W+/_/g;
    my $sub = \&{"::$sub_name"};

    do {
        my @input_params =
	    @{$_->{INPUT}} == 1
	    ? ( ref $_->{INPUT}[0] eq 'ARRAY'
		&& ! grep( ref $_, @{$_->{INPUT}[0]} ) )
		? @{$_->{INPUT}[0]}
		: $_->{INPUT}[0]
	    : @{$_->{INPUT}};
	my $expected = $_->{OUTPUT};
	my $description = 
	    "$_->{TEST}: $sub_name( " . pp( @input_params ) . " ) == "
	    . pp(
		ref $_->{OUTPUT} eq 'ARRAY' && @{$_->{OUTPUT}} == 1
		? @{$_->{OUTPUT}}
		: $_->{OUTPUT} );
	my $output =
	    ref $_->{OUTPUT} eq 'ARRAY'
	    ? [ $sub->( @input_params ) ]
	    : $sub->( @input_params );
	    
	is $output, $expected, $description;

    } for @tests;

    done_testing;
}

sub read_task( $fd_or_filename, $wanted_task = undef ) {

    my $fd;
    if ( ref \$fd_or_filename eq 'SCALAR' ) {
        open $fd, "<", $fd_or_filename
            or die "ERROR: cannot open '$fd_or_filename': $!\n";
    }
    else {
        # non-SCALARs, like __DATA__ GLOB.
        $fd = $fd_or_filename;
    }

    my ( $task, $task_title, $task_text ) = ( -1, undef );
    while ( <$fd> ) {
        /^Task (\d+):\s*(.*?)\s*$/ and do {
            $task = $1;
            $task_title = $2
                if $wanted_task && $task == $wanted_task;
            next;
        };

        next
            if $wanted_task && $task != $wanted_task;

	$task_text .= $_;
    }

    return $task_title, $task_text;
}

sub extract_tests( $task_text ) {
    # vsay "extract_tests( ", pp( $task_text ), " )";

    # These regular expressions are used for extracting input or output
    # test data.
    my $var_name  = qr/ [\@\$]\w+ /x;
    my $literal   = qr/ ".*?" | '.*?' | [+-]?\d+ /x;
    my $bracketed = qr/ \[ [^\[]*? \] /xs;
    my $entry     = qr/ $literal | $bracketed /x;
    my $list      = qr/ $entry (?: \s*,\s* $entry )* /xs;

    # The combination of what we expect as input or output data.
    # Capture unparenthesized lists for special handling.
    my $data_re = qr/ (?<lit>      $literal )
		    | (?<list>     \[ \s* (?:$list)? \s* \] )
		    | (?<no_paren> $list ) /x;

    my @tests;
    while ( $task_text =~
	/^((?:Example|Test).*?)\s*:?\s*$ .*?
	    ^Input: \s* ( .*? ) \s*
	    ^Output: \s* ( .*? ) \s*?$ (?=(?: ^$ | \Z ))
	/xmsg )
    {
	my ( $test, $input, $output) = ( $1, $2, $3 );

	push @tests, { TEST => $test };

	for ( $input, $output ) {
	    # To avoid misinterpretations of '@' or '$' when the data is
	    # 'eval'ed, we turn all double quotes into single quotes.
	    s/"/'/g;

	    # We convert 'barewords' into quoted strings.
	    # We search for these patterns, but we just skip them without
	    # changing them:
	    #  * 'Input:', 'Output:' at the beginning of the string,
	    #  * quoted strings,
	    #  * variable names having a $ or @ sigil.
	    # After we are sure it's none of those, we also check unquoted
	    # 'barewords' (here: combinations of letters, digits or underscores,
	    # starting with a letter) and enclose them in single quotes.
	    my $bareword = qr/[a-z_][a-z0-9_]*/i;
	    while ( / ^Input: | ^Output: | '.*?' | [\$\@]$bareword
		    | ( $bareword ) /xg )
	    {
		if ( $1 ) {
		    my $p = pos();
		    substr $_, $p - length( $1 ), length( $1 ), "'$1'";
		    pos = $p + 2;
		}
	    }

	    # As all arrays will be stored as array references, so we just
	    # convert parentheses (...) to angle brackets [...].
	    s/\(/\[/g;
	    s/\)/\]/g;

	    # Add missing commas between literals.
	    while ( s/($literal)\s+($literal)/$1, $2/ ) {}
	}

	while ( $input =~ / ($var_name) \s* = \s* ($data_re) /xg ) {
	    push @{$tests[-1]{VARIABLE_NAMES}}, $1;
	    push @{$tests[-1]{INPUT}}, eval( $+{no_paren} ? "[ $2 ]" : $2 );
        };

	while ( $output =~ /^\s* ($data_re) $/xg ) {
	    $tests[-1]{OUTPUT} = eval( $+{no_paren} ? "[ $1 ]" : $1 );
        };
    }
    return @tests;
}

1;
