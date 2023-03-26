#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment  
209-Task 2: Merge Account           Submitted by: Mohammad S Anwar
Given an array of accounts i.e. name with list of email addresses,
merge the accounts where possible. Accounts can only be merged if
they have at least one email address in common.

Example 1:

Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
                     ["B", "b1@b.com"],
                     ["A", "a3@a.com", "a1@a.com"] ]
                   ]

Output: [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"],
          ["B", "b1@b.com"] ]
Example 2:

Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
                     ["B", "b1@b.com"],
                     ["A", "a3@a.com"],
                     ["B"m "b2@b.com", "b1@b.com"] ]

Output: [ ["A", "a1@a.com", "a2@a.com"],
          ["A", "a3@a.com"],
          ["B", "b1@b.com", "b2@b.com"] ]

=end comment


subset Accno of Any where m/ ^ <:Lu> \d \d $ /;
subset Addr  of Any where m/^ (<:Ll>  \d ** 3) | (<:Lu> ** 4) $/;

sub dsay(*@a ) {;};

my @Data =
    # a/c  addr ...
    [< A01 a010 a011 CCCC >],
    [< A02 a020 a022 BBBB >],
    [< A03 a030 >],
    [ 'A04', ],
    [< A07 BBBB >],
    [< A08 a070 a071 >],
    [< A09 a080 a081 CCCC>],
    [< A10 a101 >],
    [< A11 a111 CCCC>],
;

sub MAIN () { 
    say "Input: @accounts = [";
    say "    ", $_.raku for @Data; 
    say "                  ]";
    say "Output: [";
    say "    ", $_.raku for combine-accounts( @Data);
    say "        ]";
}

#  Combine all possible a/c.
sub combine-accounts( @database --> Array ) {

    my (%by-ac, %by-addr, %ac2expand, %ac2drop);

    # Hash each a/c.
    for @database -> @d {
        %by-ac{@d.head} = [ @d.tail(*-1)]; # XXX Simpler put all in values.
    }

    # Invert a/c to key by address.
    %by-addr.append: %by-ac.invert;

    for %by-addr.keys -> $k {
        when %by-addr{ $k} ~~ Str {      # Address has only one acct so
            %by-addr{$k}:delete;         # no work.
        }

        my $key = choose-ac-to-expand( %by-addr{$k});  
        %ac2expand{$key} = %by-addr{$k}.values.grep(* !~~ $key).Array;

        for %by-addr{$k}.values.grep(* !~~ $key).Array {
            %ac2drop{ $_ }++ ;
    }   }

    my @expanded = merge-acs( %ac2expand, %by-ac);
    for @expanded -> ( :key($k), :value($v) ) {
        %by-ac{$k} = $v;
    }
    for %ac2drop.keys -> $k {
        %by-ac{$k}:delete;
    }

    my @new;
    for %by-ac.keys.sort -> $k {
        @new.push: [$k, |%by-ac{$k}] ; # | %by-ac{$k} ];
    }
    return @new;
}

# Merge all accts that need combining.
sub merge-acs( %keepers, %by-ac --> Array ) {
    my @updated;
    for %keepers.pairs -> $kp {
        @updated.push: expand-ac( $kp, %by-ac);
    }
    return @updated;
}

# Merge accounts into the a/c indicated by the Pair $keep.
sub expand-ac( $keep, %by-ac --> Pair ) {
    my $key = $keep.key;
    my @value = $keep.value.Array ;

    for [$key, | $keep.value] -> $pack-me {
        @value.push: | %by-ac{$pack-me};
    }
    $key => @value.unique.Array;
}

# Choose which a/c to expand vs. consume.
sub choose-ac-to-expand( @ac --> Accno) { @ac.min( :by( &[leg])); }


