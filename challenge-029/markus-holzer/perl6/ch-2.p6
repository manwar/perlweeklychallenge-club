use NativeCall;

constant WCHAR              = uint16;
constant INT                = int32;
constant UINT               = uint32;
constant HANDLE             = Pointer[void];
constant LPWCTSTR           = CArray[WCHAR];
constant MB_ICONEXCLAMATION = 0x00000030;

sub MessageBoxW( HANDLE, LPWCTSTR, LPWCTSTR, UINT ) is native('user32') returns INT { * };

MessageBoxW( my $handle, to-c-str("Raku is awesome"), to-c-str("Hello World"), MB_ICONEXCLAMATION );

sub to-c-str( Str $str ) returns CArray[WCHAR]
{
    my @str := CArray[WCHAR].new;
    for ( $str.comb ).kv -> $i, $char { @str[$i] = $char.ord; }
    @str[ $str.chars ] = 0;
    @str;
}
