#!/bin/sh -
#
# shell script to invoke Perl one-liner.
#
# Task 1: "Fun Time
# 
# You are given a time (12 hour / 24 hour).
# 
# Write a script to convert the given time from 12 hour format to 24 hour
# format and vice versa.
# 
# Ideally we expect a one-liner.
# 
# Example 1:
# 	Input: 05:15 pm or 05:15pm
# 	Output: 17:15
# 
# Example 2:
# 	Input: 19:15
# 	Output: 07:15 pm or 07:15pm
# "
# 
# My notes: very simple, I like one liners.  Here are two versions:
# 
# first: input (h,m,s), error checking, output (h,m,t)
#perl -E '$_=join(" ",@ARGV); /^(\d+):(\d\d)\s*([ap]m)$/||die "bad $_"; ($h,$m,$s)=($1,$2,$3); $h+=12 if $s eq "pm" && $h<12; $t=$s ? "":($h>11?"pm":"am");$h-=12 if ! $s && $h>12;say "$h:$m$t"' $*

# second: reuse s, same amount of error checking, modal "if", 2 chars longer
perl -E '$_=join(" ",@ARGV); /^(\d+):(\d\d)\s*([ap]m)$/||die "bad $_"; ($h,$m,$s)=($1,$2,$3); if( $s ) {$h+=12 if $s eq "pm" && $h<12;$s=""}else{$s=$h>11?"pm":"am";$h-=12 if $h>12} say "$h:$m$s"' $*
