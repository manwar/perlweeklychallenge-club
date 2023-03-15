#!/usr/bin/perl

use v5.16;
use warnings;

### Input and Output

main: {
    my %urlparts = parse_url(shift);
    say "$_: $urlparts{$_}" for keys %urlparts;
}


### Implementation

# Do not verify the individual parts' syntax.

sub parse_url {
    shift =~ m{^
        (?<schema>.+?):             # schema is mandatory
        (?://
            (?:
                (?<userinfo>.+?)\@  # userinfo is optional
            )?
            (?<host>[^/:]+?)        # host is mandatory in authority
            (?:
                :(?<port>[^/]+?)    # port is optional
            )?
            (?=/|$)                 # path must start with / if authority exists
        )?
        (?<path>[^?]*?)             # path is mandatory, but may be empty 
        (?:
            \?(?<query>[^#]+?)      # query is optional
        )?
        (?:
            \#(?<fragment>.*)       # fragment is optional
        )?
        $}x;
    (%+);
}
