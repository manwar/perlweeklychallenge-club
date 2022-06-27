#!/bin/sh
perl -E '$_="N"; $" = "+" ; while ($sol < 20) {$_.="NN";my @sum;/^(N+?)\1+$(?{push @sum,length$1})(?!)/;eval "@sum" > length() and ++$sol and say length()," < ", eval "@sum" , " = ", "@sum" }'
