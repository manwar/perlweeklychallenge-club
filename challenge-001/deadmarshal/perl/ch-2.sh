#!/bin/bash

perl -E 'foreach (1..20){if($_ % 3 == 0 && $_ % 5 == 0){say "$_ : fizzbuzz"}elsif($_ % 5 == 0){say "$_ : buzz"}elsif($_ % 3 == 0){say "$_ : fizz"}}'
