# This should really follow the spec or use something from CPAN
class Mail
{
    has Str  $.address;
    has Str  $.domain;
    has Str  $.mailbox;
    has Str  $.norm;
    has Bool $.valid;

    method Str { $!address }

    submethod TWEAK( :$!address )
    {
        my $index = $!address.index: '@';
        return unless $index && 0 < $index < $!address.chars - 1;

        $!mailbox = $!address.substr: 0, $index;
        $!domain  = lc $!address.substr: $index + 1, *;
        $!norm    = $!mailbox ~ '@' ~ $!domain;
        $!valid   = True;
    }
}

subset FileIsReadable   where { .IO.f && .IO.e && .IO.r }
subset FilesAreReadable where { .all ~~ FileIsReadable }

#| read from files
multi sub MAIN( 
    Bool :$u,                       #= unique. filters duplicates
    *@files where FilesAreReadable  #= files containing email addresses, 1 per line 
) {
    output-email-addresses $u, sort-mail-addresses @files.map: *.IO.open( :r ) }

#| read from STDIN 
multi sub MAIN( Bool :$u ) {
    output-email-addresses $u, sort-mail-addresses $*IN }

# catch bad arguments
multi sub MAIN( Bool :$u, *@ ) is hidden-from-USAGE {
    $*USAGE.say }

sub output-email-addresses( $unique, @addresses ) {
    .address.say for $unique
        ?? @addresses.squish( as => *.norm ) 
        !! @addresses } 

multi sub sort-mail-addresses( $handles where { .cache.all ~~ IO::Handle } ) 
{
    my &address = -> $address { Mail.new( :$address ) }
    my &valid   = -> $mail    { $mail.valid || $*ERR.say("Bad data <$mail>") && False }
    my &sort    = -> $a, $b   { $a.domain cmp $b.domain || $a.mailbox cmp $b.mailbox }

    $handles
        .map( | *.lines )
        .map( &address )
        .grep( &valid )
        .sort( &sort )
}