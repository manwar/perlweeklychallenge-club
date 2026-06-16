#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 378 Task 2: Sum of Words
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub sum_of_words( $str1, $str2, $str3 ) {
    my @results;
    return @results;
}

# Read test data from the accompanying '.json' file and run the tests.
# (Fixed boilerplate code, no changes needed.)

use Test2::V0 qw( -no_srand );
# Avoid messages about table width in case of test failures.
# (Term::Table::Util::term_size comes with Test2::V0.)
$ENV{TABLE_TERM_SIZE} //= Term::Table::Util::term_size() // 80;

# Read the test data from the JSON file.
use JSON::PP qw( decode_json );
( my $json_file = $0 ) =~ s/\.pl$/.json/;
note "reading tests from $json_file";
my $json_text = -f $json_file
    && do { local ( @ARGV, $/ ) = $json_file; <> }
    or die "could not read test data from $json_file\n";
my $json_data = decode_json( $json_text );

# Convert any expected output strings "true" and "false"
# as well as JSON Boolean constants true and false
# into Test2::V0::Compare T and F conditions.
for ( @{ $json_data->{examples} } ) {
    for ( @{ $_->{out} } ) {
        if ( /^(?:(true)|(false))$/i || JSON::PP::is_bool( $_ ) ) {
            $_ = $1 ? T : $2 ? F : $_ ? T : F;
        }
    }
}

# Run the tests, calling the subroutine by its generated name.
( my $sub_name = lc $json_data->{challenge}{name} ) =~ s/[^_a-z]+/_/g;
no strict 'refs';
is [ "::$sub_name"->( @{ $_->{in} } ) ], $_->{out}, $_->{name}
    for @{ $json_data->{examples} };
done_testing;
