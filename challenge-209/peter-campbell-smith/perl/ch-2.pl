#!/usr/bin/perl

# Peter Campbell Smith - 2023-03-20

use v5.28;
use utf8;
use warnings;

# You are given an array of accounts, ie name with list of email addresses.
# Write a script to merge the accounts where possible. The accounts can only 
# be merged if they have at least one email address in common.

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/209/2

merge_accounts(['A', 'a1@a.com', 'a2@a.com'],
	['B', 'b1@b.com'],
	['A', 'a3@a.com', 'a1@a.com']);
merge_accounts(['A', 'a1@a.com', 'a2@a.com'],
    ['B', 'b1@b.com'],
    ['A', 'a3@a.com'],
    ['B', 'b2@b.com', 'b1@b.com']);
merge_accounts(['fred', 'fred@gmail.com', 'fgh@fgh.com', 'freddy@home.org'], 
	['frederick', 'freddy@home.org'],
	['fbloggs', 'fbloggs@bloggs.co.uk'],
	['mary', 'freddy@home.org', 'mary@home.org']);

sub merge_accounts {
	
	my (@accounts, $a, $j, $k, @acct_name, @emails, $merge, %owns_emails, $email, $rubric, 
		$line, %lines, $owner, $rubric1);
	
	@accounts = @_;  # array of refs to accts
	
	# loop over accounts
	for $j (0 .. scalar @accounts - 1) {
		
		# loop over account details
		$merge = -1;  
		for $k (0 .. scalar @{$accounts[$j]} - 1) {

			# save account name and emails
			if ($k == 0) {
				$acct_name[$j] = $accounts[$j]->[0];
			} else {
				$email = $accounts[$j]->[$k];
				
				# mark for merging if email has been seen in a previous acct
				if (defined $owns_emails{$email}) {
					$merge = $owns_emails{$email};
				
				# or record as seen here
				} else {
					$owns_emails{$email} = $j;
				}
			}
		}
		
		# move emails from this account to $merge
		if ($merge >= 0) {
			for $email (keys %owns_emails) {
				if ($owns_emails{$email} == $j) {
					$owns_emails{$email} = $merge;
				}
			}
		}			
	}
	
	# format input
	say qq{\nInput:  \@accounts = [};
	$rubric = $rubric1 = '';
	for $j (0 .. scalar @accounts - 1) {
		$rubric1 = '';
		for $k (0 .. scalar @{$accounts[$j]} - 1) {
			$rubric1 .=  qq{'$accounts[$j]->[$k]', };
		}
		$rubric1 =~ s|, $||;
		$rubric .= qq{   [$rubric1],\n};
	}
	$rubric =~ s|,\n$|]\n|;
	say qq{$rubric};
	
	# and output
	for $email (sort keys %owns_emails) {
		$owner = $owns_emails{$email};
		$lines{$owner} .= qq['$email', ];
	}
	
	$rubric = '';
	for $owner (sort keys %lines) {
		$lines{$owner} =~ s|, $|],|;
		$rubric .= qq{   ['$accounts[$owner]->[0]', $lines{$owner}\n};
	}
	$rubric =~ s|,\n$|]|;
	say qq{Output: \@accounts = [\n$rubric};
}
