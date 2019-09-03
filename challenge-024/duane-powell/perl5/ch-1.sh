#!/bin/bash
#generate 10 char random passwords
perl -le 'print map { (0..9,A..Z,a..z)[rand 62] } 1..10'

