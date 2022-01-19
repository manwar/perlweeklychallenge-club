#!/bin/sh
perl -MMath::Prime::Util=:all -E 'say nth_prime(10001)'
