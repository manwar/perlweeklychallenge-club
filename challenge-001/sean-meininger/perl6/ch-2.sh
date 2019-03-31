perl6 -e 'for 1..20 { when $_ %% 3 {print "fizz"; proceed}; when $_ %% 5 {print "buzz"; proceed}; when $_ !%%3 and $_ !%%5 {print $_; proceed }; print "\n"; }'
