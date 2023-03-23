#! /usr/bin/env gforth

\ Challenge 209
\ 
\ Task 2: Merge Account
\ Submitted by: Mohammad S Anwar
\ 
\ You are given an array of accounts i.e. name with list of email addresses.
\ 
\ Write a script to merge the accounts where possible. The accounts can only
\ be merged if they have at least one email address in common.
\ 
\ Example 1:
\ 
\ Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
\                      ["B", "b1@b.com"],
\                      ["A", "a3@a.com", "a1@a.com"] ]
\                    ]
\ 
\ Output: [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"],
\           ["B", "b1@b.com"] ]
\ 
\ Example 2:
\ 
\ Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
\                      ["B", "b1@b.com"],
\                      ["A", "a3@a.com"],
\                      ["B", "b2@b.com", "b1@b.com"] ]
\ 
\ Output: [ ["A", "a1@a.com", "a2@a.com"],
\           ["A", "a3@a.com"],
\           ["B", "b1@b.com", "b2@b.com"] ]
