#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'none';  # really!

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [name...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

name...
    print The Name Game lyrics for each name

    call "$0 katie billy fred marsha a-nita antoi-nette ma-donna"
    to show the lyrics for all the names mentioned in the wiki page.


EOS


### Input and Output

print the_name_game($_), "\n" for @ARGV;


### Implementation

# At first sight this is seemingly trivial, though the rules are not too
# specific.  But there be dragons.
#
# Derive the variants of $name.  The variants are:
# t: title case
# s: stressed remainder in title case
# b, f, m: remaining name prefixed with given letter
#
# Cutting off a leading single consonant.  A leading "y" is regarded as
# a consonant if followed by a vowel and as a vowel otherwise.  The "h"
# is dropped before and after a consonant.  Treating q/gu/gi specially
# depending on a following vowel and taking 'ph' as 'f'.  Even then the
# remainder may start with the to-be-prefixed letter...
#
# Furthermore, the first syllable shall be dropped for names not
# stressed on it, after the full name has been said once.  This doesn't
# seem to make much sense as a general rule.  Instead *all* unstressed
# leading syllables are dropped here.  Not trying an algorithmic
# detection as this seems to be impossible and thus this information has
# to be provided in the input.  The stressed syllable must be prepended
# with a hyphen, e.g. "a-nita", "antoi-nette", "ma-donna".
#
# See test cases below.
sub name {
    # Operating on default input.
    local $_ = lc shift;
    my %name;

    # Title case w/o hyphen.
    $name{t} = ucfirst tr/-//dr;

    # Drop any unstressed leading part.
    s/.*-//;

    # Title case stressed remainder.
    $name{s} = ucfirst;

    # Remove the first consonant-like letter(s) and capture the common
    # ones.
    s{^(?|
            y (?=[aeiou])  |
            qu             |
            gu (?=[ei])    |
            gi (?=[aou])   |
            h ( (?&CONS) ) |    # rare cases
            ( (?&CONS) h? )     # consider ch, ph, rh, sh, th...
        )
        (?(DEFINE) (?<CONS>[bcdfghj-np-tv-xz]) )}
    {}x;

    # Convert 'ph' to 'f' in the removed letters.
    my $r = ($1 // '') =~ s/ph/f/r;

    # Generate the prefixed variants.
    for my $p (qw(b f m)) {
        # Do not prepend the letter if it was removed or
        # it is the start of the remainder.
        $name{$p} = $p x (none {/^$p/} $r, $_) . $_;
    }

    \%name;
}

# Generate The Name Game lyrics for a name
sub the_name_game {
    my $names = name(shift);
    sprintf "%s, %s, bo-%s,\nBonana-fanna fo-%s\nFee fi mo-%s\n%1\$s!\n",
        $names->{t}, $names->{s}, $names->{b}, $names->{f}, $names->{m};
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is the_name_game('katie'), <<EOS =~ s/^\s*//gmr, 'example';
            Katie, Katie, bo-batie,
            Bonana-fanna fo-fatie
            Fee fi mo-matie
            Katie!
EOS
    }

    SKIP: {
        skip "tests" unless $tests;
        is name('katie'), hash {field b => 'batie'; field f => 'fatie';
            field m => 'matie'; field t => 'Katie'; field s => 'Katie'; end};
        is name('billy'), hash {field b => 'illy'; field f => 'filly'; etc};
        is name('fred'), hash {field b => 'bred'; field f => 'red'; etc};
        is name('marsha'), hash {field b => 'barsha'; field m => 'arsha'; etc};
        is name('yvan'), hash {field b => 'byvan'; etc};
        is name('yuri'), hash {field b => 'buri'; etc};
        is name('qemal'), hash {field b => 'bemal'; etc};
        is name('quincy'), hash {field b => 'bincy'; etc};
        is name('gunter'), hash {field b => 'bunter'; etc};
        is name('guido'), hash {field b => 'bido'; etc};
        is name('gina'), hash {field b => 'bina'; etc};
        is name('gianna'), hash {field b => 'banna'; etc};
        is name('charly'), hash {field b => 'barly'; etc};
        is name('phil'), hash {field b => 'bil'; field f => 'il'; etc};
        is name('rhonda'), hash {field b => 'bonda'; etc};
        is name('sharon'), hash {field b => 'baron'; etc};
        is name('theo'), hash {field b => 'beo'; etc};

        # Once I got this wrong.
        is name('tiffany'), hash {field f => 'fiffany'; etc};

        # Exotics.
        is name('smaida'), hash {field b => 'bmaida'; field m => 'maida'; etc};
        is name('bhreagh'), hash {field b => 'reagh'; field f => 'freagh'; etc};
        is name('mher'), hash {field b => 'ber'; field m => 'er'; etc};
        is name('hmayak'), hash {field b => 'bayak'; field m => 'ayak'; etc};
        # Most likely this does not exist as a given name, but it sounds
        # funny.
        is name('hrmony'), hash {field b => 'bmony'; field m => 'mony'; etc};
        
        # Differing stresses.
        is name('ma-donna'), hash {field t => 'Madonna'; field s => 'Donna';
            field b => 'bonna'; field f => 'fonna'; field m => 'monna'; end};
        is name('anaxi-mander'), hash {field s => 'Mander';
            field b => 'bander'; field m => 'ander'; etc}; 

        # Finally.
        is the_name_game('ma-donna'), <<EOS =~ s/^\s*//gmr;
            Madonna, Donna, bo-bonna,
            Bonana-fanna fo-fonna
            Fee fi mo-monna
            Madonna!
EOS
	}

    done_testing;
    exit;
}
