grammar G::URLish {
  regex TOP {
    ^ <scheme> < : :// >
    <userinfo>?
    [ <host> [ ':' <port> ]? '/' ]?
    <path>
    [ '?' <query> ]?
    [ '#' <fragment> ] ? $
  }
  proto regex userinfo		{ * }
  regex userinfo:sym<user-pass> { <user> [ ':' <password> ]? '@'                             }
  regex user			{ <.xpalpha>+                                                }
  regex password		{ <.xpalpha>+                                                }
  regex host			{ <.xpalpha>+                                                }
  token port			{ <.digit>+                                                  }
  # For compatibility with the example, but I don't think : is valid here.
  regex scheme			{ <.ialpha>+ [ ':' <.ialpha>+ ]?                             }
  regex path			{ [ <.xpalpha>* ]+ % '/'                                     }
  regex query			{ <param>+ % <[\&;]>                                         }
  regex param			{ $<key> = [ <.xalpha>+ ] [ '=' $<value> = [ <.xalpha>+ ] ]? }
  token fragment		{ <.xalpha>+                                                 }
  token xalpha			{ <.alpha> | <.digit> | <.safe> | <.extra> | <.escape>       }
  token xpalpha			{ <.xalpha> | '+'                                            }
  token ialpha			{ <.alpha> [ <.xalpha>+ ]                                    }
  token alpha			{ <[a..z A..Z]>                                              }
  token digit			{ <[0..9]>                                                   }
  token safe			{ <[$ \- _ @ . &]>                                           }
  token extra			{ <[! * " ' ( ) ,]>                                          }
  token reserved		{ <[= ; / # ? : ]> || ' '                                    }
  token escape			{ '%' <[0..9 a..z A..Z]> ** 2                                }
  token national		{ <[{ } | \[ \] \\ ^ ~]>                                     }
  token punctuation		{ <[< >]>                                                    }
}

class URL::UserInfo {
  has $.user is required;
  has $.password;
}

my subset Port of Int where 0 < * < 65536;

class URL {
  has Str           $.scheme is required;
  has URL::UserInfo $.userinfo;
  has Str           $.host;
  has Port          $.port;
  has Str           $.path is required;
  has               %.query;
  has Str           $.fragment;
}

my sub urldecode($_) {
  S:g/ '%' ( <[a..f A..F 0..9]> ** 2 )/{(~$0).parse-base(16).chr()}/;
}

class A::URLish {
  method userinfo:sym<user-pass>($/) {
    make URL::UserInfo.new(
      :user(~$<user>)
      :password(~($<password> || '') || Nil)
    );
  }
  
  method TOP($/) {
    my $userinfo = $<userinfo>.?made || URL::UserInfo;

    my %query;

    if $<query><param> {
      for $<query><param> {
	%query.push: urldecode(~ .<key>) => .<value> ?? urldecode(~ .<value>) !! True;
      }
    }
    
    make URL.new(
      :scheme(~ $<scheme>                   )
      :$userinfo
      :host(~ ($<host> || '') || Nil        )
      :port(+ ($<port> || 0 ) || Nil        )
      :path(~ $<path>                       )
      :%query
      :fragment(~ ($<fragment> || '') || Nil)
    )
  }
}

sub MAIN($path = 'jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1') {
  say G::URLish.parse($path, actions => A::URLish.new).made.perl;
}
