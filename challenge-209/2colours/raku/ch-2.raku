#!/usr/bin/env raku

use Email::Valid; # zef install Email::Valid
my $email = Email::Valid.new;

# Constraints:
# - the name can't have quotation marks

my token name { '"' <( .*? )> '"' }
my token email { '"' <( .*? )> '"' <?{ $email.validate($/.Str) }> }
my token account { '[' <name> [ ',' <email>+ % ',' ]? ']' }
subset AccountList of Str where /^ '[' <account>* % ',' ']' $/;

use MONKEY-TYPING;
augment class Array {
  proto method unify-transitive is nodal {*}
  multi method unify-transitive([]:) { [] }
  multi method unify-transitive([@emails-head, **@rest]:) {
    my @unified-rest = @rest.unify-transitive;
    my @result;
    @result.push: @emails-head;
    for @unified-rest -> @emails-current {
      given @result.head {
        if $_ (&) @emails-current {
          .append: keys(@emails-current (-) $_);
        }
        else {
          @result.push: @emails-current;
        }
      }
    }
    @result
  }
}

sub build-account-str($name, @mails) {
  my $mails-part = @mails.map('"' ~ * ~ '"').join(', ');
  qq:to/END/.chomp
  ["$name"{", $_" if .so given $mails-part}]
  END
}

sub MAIN(Str $accounts) {
  die 'Please supply a valid list of accounts.' unless $accounts.subst(/\s/, '', :g) ~~ AccountList;
  my @accounts <==
    $<account>.map: { .<name>.Str => .<email>>>.Str };
  @accounts
    .classify: *.key, as => *.value andthen
    .duckmap: *.unify-transitive andthen
    .map: {slip(.key X[&build-account-str] .value[])} andthen
    .join: ', ' andthen
    "[$_]" andthen
    .say;
}
