use experimental :cached;

unit sub MAIN( Int $N );

sub bits( $n ) is cached {
    $n !%% 2 + bits( $n div 2 ) if $n > 0 || 0 }

say ($N...1).map( &bits ).sum % 1000000007;