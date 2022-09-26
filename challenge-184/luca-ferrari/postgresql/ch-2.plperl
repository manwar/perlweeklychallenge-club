-- Perl Weekly Challenge 184
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc184;

CREATE OR REPLACE FUNCTION
pwc184.task2_plperl( text[] )
RETURNS TABLE( n text, l text )
AS $CODE$


my @numbers;
my @letters;

for my $current_string ( @{ $_[0] } ) {
    my @parts = split //, $current_string;
    
    for ( @parts ) {
        push @numbers, $_ if ( $_ =~ /\d/ );
        push @letters, $_ if ( $_ =~ /[a-z]/i );
    }
}

return_next( { n => join( ',', @numbers ),
          l => join(',', @letters ) } );
return undef;          

$CODE$
LANGUAGE plperl;
