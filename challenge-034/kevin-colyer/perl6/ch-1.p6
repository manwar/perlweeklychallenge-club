#!/usr/bin/perl6
use v6;

use Test;

=begin pod

Task 34.1

Write a program that demonstrates using hash slices and/or array slices.

Task 34.2

Write a program that demonstrates a dispatch table.

    SEE SUB DRINK FOR BOTH TASKS COMPLETED IN ONE LINE!

=end pod

# globals
constant OFF_STAGE="OFF_STAGE";
constant CARRIED="CARRIED";
constant WORN="WORN";

## from Terminal::Width
my $width=80;
constant WIDTH = try {
    run('tput', 'cols', :out).out.slurp-rest.trim.Int
} // $width;

my %directions =
    n => "north",
    s => "south",
    e => "east",
    w => "west",
;

my %flags =
    _debug => False,
    _author => "Kevin Colyer", _if_title => "The Dispatch Table Adventure", _version => "1.0",

    score => 0, max_score => 2, moves => 0,
    confused => False,
    location => "start",
;

my %rooms =
#     "roomname" => { name => "shortname", desc => "descrption",
#         to => { n => "roomname" },
#     },
    "start" => { name => "The Beginning", desc => "You are standing on an gigantic letter X painted on the tarmac floor of a walled courtyard.",
        to => { n => "lab", e => "eastwall", w=> "westwall" },
    },
    "eastwall" => { name => "East wall", desc => "You are standing under the eastern wall. It towers above you.",
        to => { w => "start" },
    },
    "westwall" => { name => "West wall", desc => "You are standing next to the western wall. It is way to high to climb.",
        to => { e => "start" },
    },
    "lab" => { name => "Laboratory", desc => "You are what feels like a chemist's laboratory, but much more exciting and mysterious. Various tubes, glasses and flasks are connected in complicated manners.",
        to => { s => "start" },
    },
;

my %objects =
    lamp => { name => "a lamp", noun => "lamp", desc => "an antique brass lamp", in => "lab" },
    pebble => { name => "a pebble",noun => "pebble", desc => "an uninteresting pebble", in => "start" },
    keys => { name => "some keys", noun => "keys", desc => "car keys", in => CARRIED },
    fizzyflask => { name=> "a fizzy flask", noun => "flask", adj => "fizzy", desc => "a flask of fizzy purple liquid", in => "lab", drinkable => True},
    bubblyflask => { name=> "a bubbly flask", noun => "flask", adj => "bubbly",  desc => "a flask of bubbly green liquid", in => "lab", drinkable => True},
;

##############################################
# DISPATCH TABLE
my %dispatch =
    debug => &_debug,
    test => &_test,

    save => &_savegame,

    help => &help,
    h => &help,
    north => &north,
    n => &north,
    south => &south,
    s => &south,
    east => &east,
    e => &east,
    west => &west,
    w => &west,
    quit => &quit,
    q => &quit,
    examine => &examine,
    x => &examine,
    look => &look,
    l => &look,
    score => &score,
    inventory => &inventory,
    i => &inventory,
    get => &get,
    take => &get,
    drop => &drop,
    drink => &drink,
;

##############################################
# start and welcome
say "Welcome to {%flags<_if_title>} by {%flags<_author>} version {%flags<_version>}\nType 'help' if stuck and 'quit' to end.\n";

say word_wrap look("","","");

##############################################
# main loop of program
loop {
    my $cmd = prompt "Tell me what to do: ";
    $cmd=$cmd.trim.lc;
    next if $cmd.chars==0;

    $cmd ~~ / ^^ (\w+) \s* (\w*) \s* (.*) $$ /;
    my ($v,$a,$n) = ~$0,~$1,~$2;

    # switch adjective to a noun if there is no noun
    if $a.chars && $n.chars==0 { $n=$a; $a="" }

    say "verb:[$v] adj:[$a] noun:[$n]" if %flags<_debug>;

    # error check
    if %dispatch{$v}:!exists { say "I don't know how to '$v'"; next };

    # dispatch to handler
    say word_wrap( %dispatch{$v}($v,$a,$n) );

    if %flags<location> eq "start" and %flags<score> == %flags<max_score> {
        say word_wrap( "\nIncredibly you have made it to the end of the game scoring a whopping {%flags<score>} points!\nThanks for playing!\n\n" );
        exit;
    }
}

##############################################
# subs to dispatch from
sub north($v,$a,$n) {
    say "You stagger and sway your way around..." if %flags<confused>==True;
    return "You can't go that way." if %rooms{%flags<location>}<to><n>:!exists;
    %flags<location>=%rooms{%flags<location>}<to><n>;
    look($v,$a,$n);
};

sub south($v,$a,$n) {
    say "You stagger and sway your way around..." if %flags<confused>==True;
    return "You can't go that way." if %rooms{%flags<location>}<to><s>:!exists;
    %flags<location>=%rooms{%flags<location>}<to><s>;
    look($v,$a,$n);
};

sub east($v,$a,$n) {
    say "You stagger and sway your way around..." if %flags<confused>==True;
    return "You can't go that way." if %rooms{%flags<location>}<to><e>:!exists;
    %flags<location>=%rooms{%flags<location>}<to><e>;
    look($v,$a,$n);
};

sub west($v,$a,$n) {
    say "You stagger and sway your way around..." if %flags<confused>==True;
    return "You can't go that way." if %rooms{%flags<location>}<to><w>:!exists;
    %flags<location>=%rooms{%flags<location>}<to><w>;
    look($v,$a,$n);
};

sub help($v,$a,$n) { "You can say north,south,east,west,quit,help,examine. \nSometimes just the first letter will suffice." };

sub quit($v,$a,$n) { say "bye!"; exit };

sub examine($v,$a,$n) {
    return "I don't understand what you want to do." if $n eq ""; # need this for more than this command... (rule book?)
    my @list=flat list_of_things_here(CARRIED), list_of_things_here(%flags<location>);
    @list=@list.grep({%objects{$_}<noun> eq $n});
    if @list.elems==0 { return "I can't see $a $n." }
    my ($ok,$thing)=disambiguate(@list,$a);
    return $thing if $ok == False;
    return %objects{$thing}<desc>;
};

sub get($v,$a,$n) {
    my @list=list_of_things_here(%flags<location>);
    @list=@list.grep({%objects{$_}<noun> eq $n});
    if @list.elems==0 { return "I can't see $a $n." }
    if @list.elems==1 {
        return _get(@list[0]);
    }
    # hard case - need to disambiguate!
    # try adjective if offered
    if $a.chars>0 {
        my @refined=@list.grep({%objects{$_}<adj> eq $a});
        if @refined==1 { return _get(@list[0]) }
    }
    # otherwise
    my $s=(%objects{$_}<adj> ~ " " ~ %objects{$_}<noun> for @list).join(" or the ");
    return "Which? The $s?";
};
sub _get($item) {
        %objects{$item}<in>=CARRIED;
        return "You take the {%objects{$item}<noun>}.";
}

sub drop($v,$a,$n) {
    my @list=list_of_things_here(CARRIED);
    @list=@list.grep({%objects{$_}<noun> eq $n});
    if @list.elems==0 { return "I'm not holding $a $n." }
    my ($ok,$thing)=disambiguate(@list,$a);
    return $thing if $ok == False;
    %objects{$thing}<in>=%flags<location>;
    "Dropped.";
};

sub drink($v,$a,$n) {
    # check you can see something to drink
    my @list=flat list_of_things_here(CARRIED), list_of_things_here(%flags<location>);
    @list=@list.grep({%objects{$_}<drinkable>:exists && %objects{$_}<drinkable>==True });

    if @list.elems==0 { return "There is nothing to drink from here." };
    my ($ok,$thing)=disambiguate(@list,$a);
    return $thing if $ok == False;

    if $thing eq "bubblyflask" and %flags<confused>==True { return "The room spins even more!" };
    if $thing eq "fizzyflask" and %flags<confused>==False { return "It tastes unpleasantly of lemon and coffee." };
    #######################################
    # NOTE dispatch tables AND hash slices!
    if $thing eq "bubblyflask" {
        %dispatch{"n","north", "e","east","s","south","w","west"} = (&east, &east, &south, &south, &west, &west, &north, &north);
        %flags<confused>=True;

        return increase_score(1) ~ "The bubbly liquid tastes of melon and treacle and it goes straight to your head in seconds. You feel dizzy and confused, yet pleasantly happy.";
    }
    if $thing eq "fizzyflask" {
        %dispatch{"n","north", "e","east","s","south","w","west"} = (&north, &north, &east, &east, &south, &south, &west, &west);
        %flags<confused>=False;
        return increase_score(1) ~ "The vile taste of the fizzy liquid sobers you right up. The room swims back into focus.";
    }
};

sub inventory($v,$a,$n) {
    my $i=location_contains(CARRIED);
    return "\nYou are carrying nothing." if $i.chars==0;
    return "\nYou are carrying $i";
};

sub look($v,$a,$n) {
    my $t="\n" ~ %rooms{%flags<location>}<name> ~"\n"~ %rooms{%flags<location>}<desc>;
    #you can see
    my $i=location_contains(%flags<location>);
    $t~=" You can see $i" if $i.chars>0;
    # exits lead
    $i=exits_from(%flags<location>);
    $t~=" Exits lead $i" if $i.chars>0;

    return $t;
};

sub score($v,$a,$n) { "You have scored {%flags<score>} out of a possible {%flags<max_score>} points." };

sub _debug($v,$a,$n) { %flags<_debug>= $n~~ "on" ?? True !! False; "debug on: " ~ %flags<_debug> };

sub _test($v,$a,$n) { "testing here!" };

sub _savegame($v,$a,$n) {my $f= "save.game"; $f.IO.spurt: { flags => %flags, objects => %objects, rooms => %rooms }.perl; "Saved to file [$f]" };

##############################################
# Helper text functions
# join with and
sub join_with_and(@things) {
    return "" if @things.elems==0;
    return @things[0] if @things.elems==1;
    return @things[0]~ " and " ~ @things[1] if @things.elems==2;
    return @things[0..*-2].join(", ") ~ " and " ~ @things[*-1];
}

# word wrap
# NOTE this removes ALL double spacing!!!
sub word_wrap($t) {
    my $s="";
    for $t.lines -> $line {
        my @words=$line.words;
        my $j="";
        while @words {
            my $k=@words.shift;
            if $j.chars + $k.chars>WIDTH-2 {
                # force a wrap
                $s ~= $j ~ "\n";
                $j = $k;
            } else {
                $j ~= " " if $j !eq "";
                $j ~= $k;
            }
        }
        $s ~= $j~"\n";
    }
    return $s
}

# list of things here
sub list_of_things_here($place) {
    my @list_of_things;
    for %objects.keys -> $thing {
        @list_of_things.push($thing) if %objects{$thing}<in> eq $place;
    };
    #say @list_of_things.perl;
    return @list_of_things;
}

# disambiguate (if possible)
sub disambiguate(@things,$adj) {
    return True,@things[0] if @things.elems==1;
    # try adjective if offered
    if $adj.chars>0 {
        my @refined=@things.grep({%objects{$_}<adj> eq $adj});
        return True,@refined[0] if @refined.elems==1;
    }
    # otherwise
    my $s=(%objects{$_}<adj> ~ " " ~ %objects{$_}<noun> for @things).join(" or the ");
    return False,"Which? The $s?";
};

sub  increase_score($points) {
    %flags<score>+=$points;
    "Your score has gone up by $points! You have {%flags<score>} point(s).\n";
};

# describe contents of something
sub location_contains($place) {
    my @list_of_things= %objects{list_of_things_here($place)}»<name>;  # HASH SLICE!
    return "" unless @list_of_things.elems>0;
    return join_with_and(@list_of_things) ~ ".";
}

# describe directions from somewhere
sub exits_from($place){
    ##############################################
    # HASH SLICE!
    my @exits = %directions{%rooms{$place}<to>.keys}; # hash slice to array for directions from location
    return "" unless @exits.elems>0;
    return join_with_and(@exits) ~ ".";
};
