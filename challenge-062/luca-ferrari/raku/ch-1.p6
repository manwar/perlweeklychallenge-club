#!env raku

# Write a script that takes a list of email addresses (one per line)
# and sorts them first by the domain part of the email address,
# and then by the part to the left of the @ (known as the mailbox).
# 
# Note that the domain is case-insensitive, while the mailbox part is case sensitive.
# (Some email providers choose to ignore case, but that’s another matter entirely.)
# 
# If your script is invoked with arguments, it should treat them as file names
# and read them in order, otherwise your script should read email addresses from standard input.
#
# Bonus
# 
# Add a -u option which only includes unique email addresses in the output, just like sort -u.



sub MAIN( Bool :$u? = False, *@emails ) {
    if ( ! @emails ) {
        @emails = 'name@example.org',
        'rjt@cpan.org',
        'Name@example.org',
        'rjt@CPAN.org',
        'user@alpha.example.org';
    }


    @emails = @emails.sort( *.split( '@' )[ 0 ] ).sort( *.split( '@' )[ 1 ].lc );

    say @emails.join( "\n" ) if ! $u;
    if $u {
        my @unique-emails;

        for @emails -> $email {
            @unique-emails.push: $email.lc if ( ! @unique-emails.grep( $email.lc ) );
        }

        say @unique-emails.join( "\n" );
    }
}
