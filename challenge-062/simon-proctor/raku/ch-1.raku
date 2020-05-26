#!/usr/bin/env raku

use v6.d;

role EmailAddress {
    has Str $.value;
    has Str $.canonical-name;
    has Str $.canonical-domain;
    has Str $.canonical;

    submethod TWEAK() {
        my ( $name, $domain ) = $!value.split('@');

        $!canonical-name = $name;
        $!canonical-domain = $domain.lc;
        $!canonical = "{$!canonical-name}\@{$!canonical-domain}";
    }

    method Str () { $!value }
    method gist () { $!value }
}

#| Take a list of files read them and return the sorted list of 
multi sub MAIN(
    Bool :u(:$unique) = False, #= Return only unqiue addresses
    *@files )
{
    process-handle( handle => IO::CatHandle.new( @files ), :$unique );
}

#| Read email address from standard input and print the sorted list when done
multi sub MAIN(
    Bool :u(:$unique) = False #= Return only unqiue addresses
) {
    process-handle( handle => $*IN, :$unique );
}

sub process-handle( :$handle, :$unique = False ) {
    my @emails;
    for $handle.lines -> $email {
        @emails.push( EmailAddress.new( value => $email.chomp ) );
    }
    .say for sort-emails( @emails, :$unique );
}

sub sort-emails( @emails, Bool :$unique = False ) {
    @emails.=sort( { $^a.canonical-domain cmp $^b.canonical-domain || $^a.canonical-name cmp $^b.canonical-name } );
    @emails.=unique( as => { .canonical }, with => &[eq] ) if $unique;
    return @emails;
}
