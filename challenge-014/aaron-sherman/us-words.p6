#!/usr/bin/env perl6

# Challenge #2
# Using only the official postal (2-letter) abbreviations for the 50 U.S.
# states, write a script to find the longest English word you can spell?
# Here is the list of U.S. states abbreviations as per wikipedia page.
# This challenge was proposed by team member Neil Bowers.

# My solution is really just the one line:
#     say @wordlist.grep(/:i^@states+$/).max(*.chars);

use v6.c;

use WWW;

our $online-wordlist = 'https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt';
our $local-wordlist = '/usr/share/dict/words';

sub get-words(Bool :$web-words) {
    sub get-local-words($path) {
        $path.IO.e ?? $path.IO.lines>>.trim !! Nil
    }
    return get($online-wordlist).words if $web-words;
    get-local-words($local-wordlist) // get-local-words('words') // 
        get($online-wordlist).words;
}
sub get-states-map() {
    my @states = <
        AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS
        MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV
        WI WY>;
    my @others = <DC AS GU MP PR VI FM MH PW AA AE AP CM CZ NB PI TT>;
    my @names =
        "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado",
        "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho",
        "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine",
        "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi",
        "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire",
        "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota",
        "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island",
        "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah",
        "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin",
        "Wyoming";
    my @others-names =
        "District of Columbia", "American Samoa", "Guam",
        "Northern Mariana Islands", "Puerto Rico", "U.S. Virgin Islands",
        "Micronesia", "Marshall Islands", "Palau",
        "U.S. Armed Forces – Americas", "U.S. Armed Forces – Europe",
        "U.S. Armed Forces – Pacific", "Northern Mariana Islands",
        "Panama Canal Zone", "Nebraska", "Philippine Islands",
        "Trust Territory of the Pacific Islands";
    return {
        states => Hash.new(@states Z @names),
        others => Hash.new(@others Z @others-names),
    };
}

proto MAIN(|) {*}
multi MAIN(Bool :$test!) {
    use Test;
    my $states-map = get-states-map;
    my @states = $states-map<states>.keys;
    like 'code', /:i^@states+$/, "Pattern match a word";
    is $states-map<states><CA>, 'California', 'CA lookup';
}
multi MAIN(
        Bool :$territories, #= Include US Territories
        Bool :$verbose,     #= Verbose output
        Bool :$web-words    #= Force downloading large wordlist
) {
    my @wordlist = get-words(:$web-words).grep({.defined});
    my $states-map = get-states-map;
    my @states = $states-map<states>.keys;
    if $territories {
        @states.push($states-map<others>.keys);
    }
    @states .= sort;
    my $answer = @wordlist.grep(/:i^@states+$/).max(*.chars);
    if not $answer {
        say "Could not find a match";
    }
    if $verbose {
        my @parts = $answer ~~ m:g/(\w\w)/;
        say "{@parts>>.map({
            $states-map<states>{uc $_}//$states-map<others>{uc $_}
        }).join(' + ')} = $answer";
    } else {
        say $answer;
    }
}
