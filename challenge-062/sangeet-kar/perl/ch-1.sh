perl -F@ -alnE 'push @mails,[@F]; END {say join "@", @$_ for sort {fc(@$a[1]).@$a[0] cmp fc(@$b[1]).@$b[0]} @mails}' mails.txt 
