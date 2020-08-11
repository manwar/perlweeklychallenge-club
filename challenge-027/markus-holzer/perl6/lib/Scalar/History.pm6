use Test;

my $minumum-version = Version.new('2019.07.1.357.gd.00674.b.31');

die "Scalar::History requires $minumum-version or later"
    if ( $*PERL.compiler.version cmp $minumum-version ) == Less;

class Scalar::History::Proxy is Proxy
{
    has @!history;
    has $!position;

    # This is needed for now since the standard ways
    # like assigning in the `has` statement, TWEAK
    # and BUILD don't work with `Proxy`

    method new( :&FETCH!, :&STORE!, *%_ ) is raw
    {
        my $self := self.Proxy::new( :&FETCH, :&STORE );
        $self.VAR.TWEAK( |%_ );
        $self
    }

    method TWEAK( :$!position = 0 ) {
        # yadayada
    }

    method current-value( \SELF: )
    {
        @!history[ $!position ]
    }

    method latest-value( \SELF: )
    {
        @!history[ *-1 ]
    }

    method get-history( \SELF: Bool :$all = False )
    {
        my $to-index = $all ?? @!history.elems - 1 !! $!position;
        @!history[ ^$to-index ]
    }

    method reset-history( \SELF: )
    {
        @!history = ();
        $!position = 0;
    }

    method forward-history( \SELF: $steps )
    {
        $!position = $!position + $steps;
        $!position = @!history.elems - 1
            if $!position >= @!history.elems;
        $!position;
    }

    method rewind-history( \SELF: $steps )
    {
        $!position = $!position - $steps;
        $!position = 0
            if $!position < 0;
        $!position;
    }

    method store-value( \SELF: $new-value, $register-duplicates )
    {
        # Forget stuff after rewind
        if @!history.elems > $!position + 1
        {
            @!history.splice( $!position + 1 );
        }

        if !($new-value eqv SELF.current-value) || $register-duplicates
        {
            @!history.push( $new-value );
            $!position = @!history.elems - 1;
        }
    }
}

class Scalar::History
{
    method create( $value, ::T $type = Any, Bool :$register-duplicates = False )
    {
        return-rw Scalar::History::Proxy.new(
            FETCH => method ( \SELF: ) {
                SELF.current-value() },
            STORE => method ( \SELF: T $new-value ) {
                SELF.store-value( $new-value, $register-duplicates ); }
        ) = $value;
    }
}