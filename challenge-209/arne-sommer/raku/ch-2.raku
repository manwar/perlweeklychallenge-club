#! /usr/bin/env raku

unit sub MAIN (:v($verbose));

my @accounts1 = [ ["A", "a1@a.com", "a2@a.com"],
                  ["B", "b1@b.com"],
                  ["A", "a3@a.com", "a1@a.com"]
                ];

say "Example 1:";
merge-accounts(@accounts1);

my @accounts2 = [ ["A", "a1@a.com", "a2@a.com"],
                  ["B", "b1@b.com"],
                  ["A", "a3@a.com"],
                  ["B", "b2@b.com", "b1@b.com"]
                ];

say "\nExample2:";
merge-accounts(@accounts2);

sub merge-accounts (@accounts)
{
  my %accounts;

ACC:
  for @accounts -> @account
  {
    my $key = @account.shift;
    my @email = @account;

    if %accounts{$key}
    {
      for @(%accounts{$key}) -> @emails
      {
        if any(@emails) eq any(@email)
        {
	  say ":Append $key emails: @email[] (to @emails[])" if $verbose;
          @emails.append: @email;
          next ACC;
        }
      }
    }

    say ":Add $key emails: @email[]" if $verbose;

    %accounts{$key}.push: @email;
  }

  say "[";
  for sort keys %accounts -> $key
  {
    for @(%accounts{$key}) -> @emails
    {
      say "  [\"$key\", ", join(", ", @emails.unique.map({ "\"$_\""}) ), "],";
    }
  }
  say "]";
}
