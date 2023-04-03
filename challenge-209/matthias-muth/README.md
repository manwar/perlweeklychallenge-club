# Bits and addresses
*Challenge 209 solutions in Perl by Matthias Muth*

## Task 1: Special Bit Characters

> You are given an array of binary bits that ends with 0.<br/>
Valid sequences in the bit string are:
```
[0] -decodes-to-> "a"
[1, 0] -> "b"
[1, 1] -> "c") 
```
>Write a script to print 1 if the last character is an a otherwise print 0.

Oh. Looks like another one-liner!

The examples suggest that the bit strings are given as input in the form of an array of `0`s and `1`s.<br/>
No problem for Perl to convert the values given to the function into a character string, like so:
```perl
    join( "", @_ )
```
And then we use a regular expression for checking the validity.<br/>
The string must consist of a sequence of `0` (for `a`), `10` (for `b`) or `11` (for `c`), as many of them as we like,
but then it must be followed by a `0` (for `a`) as the last character.<br/>
And that's it!<br/>
As in Perl, the binary result of the regular expression comparison is `1` for true or `""` for false, 
we translate a 'false' into a `0` as requested.<br/>
Here we go!
```perl
sub special_bit_characters {
    return join( "", @_ ) =~ /^ ( 0 | 10 | 11 )* 0 $/x || 0;
}
```
# Merge Address

> You are given an array of accounts i.e. name with list of email addresses.<br/>
Write a script to merge the accounts where possible.
The accounts can only be merged if they have at least one email address in common.

The existing accounts are given in an 'array_ref' parameter. 
```perl
sub merge_accounts {
    my ( $input_accounts ) = $_[0];
```
We create an array for those accounts that we merge into, should any other
account have an address in common with this one.
```perl
    my @merged_accounts;
```
For any address, we keep track of the account into which this address wil be merged into
in %merged_accounts_by_address:
```perl
    my %merged_accounts_by_address;
```
Now we split up the addresses of all existing accounts into 'merged accounts',
creating a new 'merged account' whenever there is an account that cannot be merged
into another one from before.
```perl
    for ( @$input_accounts ){
        # The first entry is the name of the account,
        # all following entries a mail address.
        my ( $name, @addresses ) = @$_;

        # Check whether we already have another account for any one of our
        # addresses.
        my $merged_account =
            ( map $merged_accounts_by_address{$_},
                grep $merged_accounts_by_address{$_}, @addresses )[0];

        # If no other account so far had any of our addresses, our account will
        # be the one that will be merged into further on, if there are addresses
        # in common with other accounts. We therefore create a new entry into
        # @merged_accounts.
        # If we did find an already existing account for at least one of our
        # addresses, we use that one.
        # These 'merged accounts' remain with no addresses until later,
        # but we keep track of the addresses in %merged_accounts_by_address.
        # This way, we immediately know the account to merge for any address
        # we encounter.
        push @merged_accounts, $merged_account = [ $name ]
            unless $merged_account;
        $merged_accounts_by_address{$_} = $merged_account
            for @addresses;
    }
```
Now it's time to really fill our 'merged accounts' with addresses:
```perl
    # Add the addresses to the accounts they belong to.
    # Sorted, so that they look nice on output.
    push @{$merged_accounts_by_address{$_}}, $_
        for sort keys %merged_accounts_by_address;
````
And do some cosmetics before we return the result:
```perl
    # Also for output, sort the merged accounts by name and their first address.
    @merged_accounts =
        sort { $a->[0] cmp $b->[0] || $a->[1] cmp $b->[1] }
            @merged_accounts;

    return \@merged_accounts;
}
```

Funny that I found it more difficult to describe the process than to implement it!<br/>
Maybe it will help me if I ever read my own code again... :-)

**Thank you for the challenge!**
