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
our @EXPORT = qw(
    run_tests
    run_tests_for_subs
    $verbose %options vprint vsay
    done_testing
    pp np carp croak
);

use Data::Dump qw( pp );
use Data::Printer;
use Getopt::Long;
use Cwd qw( abs_path );
use File::Basename;
use List::Util qw( any );
use Carp;
use Test2::V0 qw( -no_srand );
use Carp;
no warnings 'experimental::signatures';

our ( $verbose, %options );
sub vprint { print @_ if $verbose };
sub vsay   { say   @_ if $verbose };

sub extract_all_tests() {

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
	# vsay $task_title;

    my @tests = (
        $local_tests      ? extract_tests( $local_tests )      : (),
	$task_description ? extract_tests( $task_description ) : (),
    );
    # vsay pp( @tests );
    return ( $task_title, @tests );
}

sub run_tests( @sub_names ) {

    $| = 1;

    GetOptions(
        "v|verbose!" => \$verbose,
    ) or do { say "usage!"; exit 2 };

    my ( $task_title, @tests ) = extract_all_tests;
    my $n_failures = 0;
    my $add_newline = 0;

    for my $sub_name ( @sub_names ? @sub_names : ( undef ) ) {
	say ""
	    if $add_newline++;
	say "Running tests for '$sub_name':"
	    if $sub_name;
	$n_failures += run_tests_for_sub( $sub_name, $task_title, @tests );
    }
    done_testing;
    return $n_failures == 0;
}

sub run_tests_for_sub( $sub_name, $task_title, @tests ) {
    ( $sub_name //= lc $task_title ) =~ s/\W+/_/g;

    my $n_failures = 0;
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
	my $diag =
	    "$sub_name( " . pp( @input_params ) . " ) "
	    . ( ( @$expected == 1 && $expected->[0] =~ /^(?:(true)|false)/ )
	        ? "is $expected->[0]"
		: ( "== " . pp( @{$_->{OUTPUT}} ) ) );

	my $name = "$_->{TEST}";
	$name .= ": $diag"
	    if $_->{TEST} =~ /^(Test|Example)(?:\s+\d+)?$/;
	$diag = "test: $diag";

	my @output = $sub->( @input_params );

	if ( @$expected == 1 && $expected->[0] =~ /^(?:(true)|false)/ ) {
	    ok $1 ? $output[0] : ! $output[0], $name, $diag // ()
		or ++$n_failures;
	}
	else {
	    is \@output, $expected, $name, $diag // ()
		or ++$n_failures;
	}

        # vsay "";

    } for @tests;

    return $n_failures;
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
    my $var_name      = qr/ [\@\$]\w+ /x;
    my $literal       = qr/ ".*?" | '.*?' | [+-]?\d+ | undef /x;
    my $bracketed     = qr/ \[ [^\[]*? \] /xs;
    my $parenthesized = qr/ \( [^\[]*? \) /xs;
    my $entry         = qr/ $literal | $bracketed | $parenthesized /x;
    my $list          = qr/ $entry (?: \s*,\s* $entry )* \s*,? /xs;

    # The combination of what we expect as input or output data.
    # Capture unparenthesized lists for special handling.
    my $data_re = qr/ (?<lit>      $literal )
		    | (?<br_list>     \[ \s* (?:$list)? \s* \] )
		    | (?<par_list>    \( \s* (?:$list)? \s* \) )
		    | (?<no_paren> $list ) /x;

    my @tests;
    while ( $task_text =~
	/^((?:Example|Test).*?)\s*:?\s*$ .*?
	    ^Input: \s* ( .*? ) \s*
	    ^Out?put: \s* ( .*? ) \s*? (?=(?: ^$ | ^\S | \Z ))
	/xmsg )
    {
	my ( $test, $input, $output) = ( $1, $2, $3 );
	# vsay pp $test, $input, $output;

	push @tests, { TEST => $test };

	# Check whether the Input: part contains any variable sigils.
	# If not, we try to convert '<Sequence of Words> = ...'
	# into '$sequence_of_words = ...'.
	# This is for specification like
	# Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2
	unless ( $input =~ /[\$\@]\w+/ ) {
	    $input =~ s{(\w+?(?: \w+?)*?)(\s*=)}{
		my ( $var_name, $equals ) = ( $1, $2 );
		'$' . lc ( $var_name =~ s/ /_/gr ) . $equals;
	    }eg;
	    # vsay "changed \$input to '$input'";
	}

	for ( $input, $output ) {
	    # To avoid misinterpretations of '@' or '$' when the data is
	    # 'eval'ed, we turn all double quotes into single quotes.
	    s/\"/'/g;

	    # We convert 'barewords' into quoted strings.
	    # We search for these patterns, but we just skip them without
	    # changing them:
	    #  * 'Input:', 'Output:' at the beginning of the string,
	    #  * quoted strings,
	    #  * variable names having a $ or @ sigil.
	    # After we are sure it's none of those, we also check unquoted
	    # 'barewords' (here: combinations of letters, digits or underscores,
	    # starting with a letter) and enclose them in single quotes.
	    my $bareword = qr/ \b (?!undef) [a-z_][a-z0-9_]* \b /ix;
	    while ( / ^Input: | ^Output: | '.*?' | [\$\@]$bareword
		    | ( $bareword ) /xg )
	    {
		if ( $1 ) {
		    my $p = pos();
		    substr $_, $p - length( $1 ), length( $1 ), "'$1'";
		    pos = $p + 2;
		}
	    }

	    # As all arrays will be stored as array references, we just
	    # convert parentheses (...) to angle brackets [...].
	    # s/\(/\[/g;
	    # s/\)/\]/g;

	    # Add missing commas between literals.
	    while ( s/($literal)\s+($literal)/$1, $2/ ) {}
	}

	while ( $input =~ / ($var_name) \s* = \s* ($data_re) /xg ) {
	    push @{$tests[-1]{VARIABLE_NAMES}}, $1;
	    push @{$tests[-1]{INPUT}},
		eval( ( $+{no_paren} || $+{par_list} ) ? "[ $2 ]" : $2 );
        };

	while ( $output =~ /^\s* ($data_re) $/xg ) {
	    local $_ = $1;
	    # vsay "\$_: <$_>";
	    # Special case:  (1,2),(3,4),(5,6)
	    # should become: [1,2],[3,4],[5,6] ]
	    if ( $+{no_paren} && /$parenthesized/ ) {
		# vsay "found special case <$_>";
		s/\(/\[/g;
		s/\)/\]/g;
	    }
	    push @{$tests[-1]{OUTPUT}},
		eval( $+{no_paren} ? "( $_ )" : $_ );
        };
    }

    unless ( @tests ) {
	# Try an alternative description format:
	# <input...> => <output...>
	my $n_examples = 0;
	while ( $task_text =~ /^( .*? ) \s* => \s* ( .* )$/xmg ) {
	    # vsay pp @{^CAPTURE};
	    push @tests, {
	        TEST => "Example " . ++$n_examples,
		INPUT => [ split " ", $1 ],
		OUTPUT => [ $2 ],
		VARIABLE_NAMES => [ '@input' ],
	    }
	}
    }

    # Use array refs for all OUTPUT lists if at least one of tests does.
    if ( any { ref $_->{OUTPUT}[0] } @tests ) {
	$_->{OUTPUT} = [ $_->{OUTPUT} ]
	    for grep { ! ref $_->{OUTPUT}[0] } @tests;
    }

    return @tests;
}

1;
