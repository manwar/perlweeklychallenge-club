#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

# This handles the following:
#
#   a{1,2}
#   a{1,2{3,4}}{5,6}b
# 
# And similar versions.  So, yes, you can nest and have multiple
# curlies. Note there is no way to "quote" commas or curlies at this
# time, but they would be reasonably straightforward to add.  I have to
# admit Parse:RecDescent is awesome just as Perl 6 grammars are.
#

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use List::Util qw(uniqstr);
use Parse::RecDescent 1.511;

my $parser = Parse::RecDescent->new(
    q{
    <autotree>
    TOP        :
        <skip:''>
        element(s?)
    element    : string | curly
    string     : /[^\{\}]+/
    curly      : '{' option(s? /,/) '}'
    option     : innerele(s)
    innerele   : curly | innerstr
    innerstr   : /[^\{\}\,]*/
}
);

MAIN: {
    die "Usage: $0 <str>" if @ARGV != 1;

    my $str   = $ARGV[0];
    my $parse = $parser->TOP( \$str );
    die "Invalid String" if ((!defined $parse) or ($str ne ''));

    my @expansion = expansion($parse, '' );
    say join "\n", uniqstr sort @expansion;
    
    exit;

    my $str1 = lc( $parse->{scheme} ) . ':';

    $str .= '//'                                   if defined $parse->{host};
    $str .= $parse->{userinfo}                     if defined $parse->{userinfo};

    if ( lc( $parse->{scheme} ) eq 'http' and defined $parse->{port} ) {
        $str .= ':' . $parse->{port} if $parse->{port} != 80;
    } elsif ( lc( $parse->{scheme} ) eq 'https' and defined $parse->{port} ) {
        $str .= ':' . $parse->{port} if $parse->{port} != 443;
    } elsif ( defined $parse->{port} ) {
        $str .= ':' . $parse->{port};
    }

    say "Scheme:   " . ( $parse->{scheme}   // '<not defined>' );
    say "Userinfo: " . ( $parse->{userinfo} // '<not defined>' );
    say "Host:     " . ( $parse->{host}     // '<not defined>' );
    say "Port:     " . ( $parse->{port}     // '<not defined>' );
    say "Path:     " . ( $parse->{path}     // '<not defined>' );
    say "Query:    " . ( $parse->{query}    // '<not defined>' );
    say "Fragment: " . ( $parse->{fragment} // '<not defined>' );

    say $str;
}

sub expansion($tree, @arr) {
    if (exists $tree->{'element(s?)'}) {
        for my $ele ($tree->{'element(s?)'}->@*) {
            @arr = expansion($ele, @arr);
        }
        return @arr;
    } elsif (exists $tree->{'innerele(s)'}) {
        for my $ele ($tree->{'innerele(s)'}->@*) {
            @arr = expansion($ele, @arr);
        }
        return @arr;
    } elsif (exists $tree->{string}) {
        return map { $_ . $tree->{string}{__VALUE__} } @arr;
    } elsif (exists $tree->{innerstr}) {
        return map { $_ . $tree->{innerstr}{__VALUE__} } @arr;
    } elsif (exists $tree->{curly}) {
        my (@copy) = @arr;
        @arr = ();
        for my $ele ($tree->{curly}{'option(s?)'}->@*) {
            push @arr, expansion($ele, @copy);
        }
        return @arr;
    } else {
        die join ' ', keys $tree->%*;
    }
}

