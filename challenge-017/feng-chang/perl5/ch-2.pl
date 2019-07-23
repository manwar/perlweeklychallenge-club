#!/bin/env perl 

use Modern::Perl;

my $s = 'jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1';

#       scheme:[//[userinfo@]host[:port]]path[?query][#fragment]
# e.g.: jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1
if ($s =~ m/^
            (?<scheme> [a-zA-Z][-+.a-zA-Z0-9]* (?: : [a-zA-Z][-+.a-zA-Z0-9]*)? )
            : (?: \/\/
                  (?:
                      (?<userinfo>
                          (?<user>     [a-z][-+.a-zA-Z0-9]*) :
                          (?<password> [-+.a-zA-Z0-9]*)
                      )
                      @
                  )?
                  (?<host> [a-zA-Z0-9][-+.a-zA-Z0-9]*) 
                  (?: : (?<port> \d+) )?
              )?
            (?<path> \/ (?: \w+? \/? )* )
            (?: \? (?<query> [a-zA-Z][-+.a-zA-Z0-9]* = \w+ (?: & [a-zA-Z][-+.a-zA-Z0-9]* = \w+)* ))?
            (?: \# (?<fragment> [a-zA-Z][-+.a-zA-Z0-9]*))?
        $/x
   ) {
    say 'scheme:   ',   $+{ scheme };
    say 'userinfo: ',   $+{ userinfo } if defined $+{ userinfo };
    #say '  user:     ', $+{ user }     if defined $+{ user };
    #say '  password: ', $+{ password } if defined $+{ password };
    say 'host:     ',   $+{ host }     if defined $+{ host };
    say 'port:     ',   $+{ port }     if defined $+{ port };
    say 'path:     ',   $+{ path };
    say 'query:    ',   $+{ query }    if defined $+{ query };
    say 'fragment: ',   $+{ fragment } if defined $+{ fragment };
}
