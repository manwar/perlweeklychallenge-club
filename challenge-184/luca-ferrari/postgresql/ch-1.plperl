-- Perl Weekly Challenge 184
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc184;

CREATE OR REPLACE FUNCTION
pwc184.task1_plperl( text[] )
RETURNS SETOF text
AS $CODE$

my $counter = 0;
for my $current_string ( @{$_[0]} ) {
    next if $current_string !~ / ^ [a-z]{2} \d{4} $ /ix;
    $counter = sprintf "%02d", $counter;
    $current_string =~ s/ ^ [a-z]{2} /$counter/xi;
    $counter++;
    return_next( $current_string );
}

return undef();
$CODE$
LANGUAGE plperl;
