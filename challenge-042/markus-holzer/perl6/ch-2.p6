sub generate-string
{
    my @braces = "(", ")";
    my $length = ( 2 ..^ 6 ).pick;
    my @string = ( 0 .. $length ).map({ @braces.pick });
    @string.join( "" );
}

sub test-string( $string )
{
    my token opening-brace { \( };
    my token closing-brace { \) };
    my token balanced-braces { 
        ( <opening-brace>+ ) <closing-brace> ** { $0.chars } 
    };
    
    so $string ~~ /^ <balanced-braces> $/;
}

for ( ^50 )
{
    my $string = generate-string;
    my $result = test-string( $string );
    say "$string is { $result ?? 'balanced' !! 'unbalanced' }";
}
