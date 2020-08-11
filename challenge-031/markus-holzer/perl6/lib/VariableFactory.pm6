class VariableFactory { * }

sub EXPORT( $var-name ) 
{
    $var-name 
        ?? %( '$*' ~ $var-name => 42 )
        !! %();
}
