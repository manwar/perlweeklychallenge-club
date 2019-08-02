#! /usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Marpa::R2;

my $dsl = << '__DSL__';

:default ::= action => [name,values]
lexeme default = latm => 1

URL            ::= Scheme (':')
                   MaybeAuthority MaybePath MaybeQuery MaybeFragment
                                                        action => build
Scheme         ::= SchemeName                           action => ::array
                 | SchemeName SubScheme                 action => ::array
SubScheme      ::= (':') SchemeName                     action => ::first
SchemeName     ::= letter SchemeBody                    action => concat
SchemeBody     ::= scheme_char SchemeBody               action => concat
                 | scheme_char                          action => ::first
MaybeAuthority ::=                                      action => ::undef
MaybeAuthority ::= ('//') MaybeUserInfo Host MaybePort  action => host
MaybeUserInfo  ::=                                      action => ::undef
MaybeUserInfo  ::= UserInfo ('@')                       action => ::first
UserInfo       ::= UserName MaybePassword               action => userinfo
UserName       ::= String
MaybePassword  ::=                                      action => ::undef
MaybePassword  ::= (':') Password                       action => ::first
Password       ::= String
Host           ::= Hostname
                 | ('[') IPv6 (']')
IPv6           ::= Hex ':' Hex ':' Hex ':' Hex ':'
                   Hex ':' Hex ':' Hex ':' Hex          action => concat
Hostname       ::= String                               action => ::first
MaybePath      ::= Path                                 action => path
Path           ::=
Path           ::= PathString                           action => ::first
PathString     ::= '/' String                           action => concat
MaybeQuery     ::=                                      action => ::undef
MaybeQuery     ::= ('?') Query                          action => query
Query          ::= QString
MaybeFragment  ::=                                      action => ::undef
MaybeFragment  ::= ('#') Fragment                       action => fragment
Fragment       ::= String
MaybePort      ::=                                      action => ::undef
MaybePort      ::= (':') Port                           action => port
Port           ::= Num
String         ::=                                      action => empty
String         ::= char String                          action => concat
                 | char                                 action => ::first
QString        ::= anychar QString                      action => concat
                 | anychar                              action => ::first
Num            ::= digit Num                            action => concat
                 | digit                                action => ::first
Hex            ::= hex Hex                              action => concat
                 | hex                                  action => ::first

anychar     ~ [\S]
letter      ~ [a-zA-Z]
scheme_char ~ [a-zA-Z+\-.]
char        ~ [\w.]
digit       ~ [0-9]
hex         ~ [0-9a-fA-F]

__DSL__

sub none     {}
sub empty    { "" }
sub host     { assign(host     => $_[0], $_[2]) }
sub port     { assign(port     => @_) }
sub query    { assign(query    => @_) }
sub fragment { assign(fragment => @_) }
sub path     { $_[0]{path} = $_[1] // "" }
sub concat   { join "", @_[ 1 .. $#_ ] }
sub userinfo { $_[0]{username} = $_[1][1], $_[0]{password} = $_[2][1] }
sub build    {
    $_[0]{scheme}    = $_[1][0];
    $_[0]{subscheme} = $_[1][1] if defined $_[1][1];
    $_[0]
}

sub assign   { $_[1]{ $_[0] } = $_[2][1] }


my $grammar = 'Marpa::R2::Scanless::G'->new({source => \$dsl});
for my $url ('http://choroba:s6cr6t@www.perl.org:80/index.asp?x=12#id',
             'https://127.0.0.1/',
             'ftp://[1:2:3:4:5:6:dead:BEEF]',
             'jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1',
) {
    say "URL: $url";
    my $recce = 'Marpa::R2::Scanless::R'->new({grammar           => $grammar,
                                               semantics_package => 'main'});
    $recce->read(\$url);
    my $struct = ${ $recce->value };
    for my $key (sort keys %$struct) {
        say "$key:\t$struct->{$key}";
    }
    say "";
}
