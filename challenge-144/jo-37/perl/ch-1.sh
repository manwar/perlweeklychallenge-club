#!/bin/sh

perl -MMath::Prime::Util=:all -E 'forsemiprimes {say} 100'
