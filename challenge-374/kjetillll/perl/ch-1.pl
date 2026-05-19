sub f {
    grep join('', sort /./g) =~ /^a+e+i+o+u+$/,
    map $_[0] =~ / (?= ( .{$_} ) ) /gx,
    5 .. length $_[0]
}


#----testing
@f = f( shift @$_ ),
print "@{[ sort @f ]}" eq "@{[ sort @$_ ]}" ? "ok" : "ERROR", " @f\n" for
[ "aeiou"          => "aeiou"                                 ],
[ "aaeeeiioouu"    => "aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu" ],
[ "aeiouuaxaeiou"  => "aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua"        ],
[ "uaeiou"         => "aeiou", "uaeio", "uaeiou"                        ],
[ "aeioaeioa"      =>                                         ],

# https://theweeklychallenge.org/blog/perl-weekly-challenge-374/
