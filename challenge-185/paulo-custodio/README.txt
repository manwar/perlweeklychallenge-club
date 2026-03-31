Perl Weekly Challenge 185
https://theweeklychallenge.org/blog/perl-weekly-challenge-185/

Task 1: MAC Address
Submitted by: Mohammad S Anwar
You are given MAC address in the form i.e. hhhh.hhhh.hhhh.

Write a script to convert the address in the form hh:hh:hh:hh:hh:hh.

Example 1
Input:  1ac2.34f0.b1c2
Output: 1a:c2:34:f0:b1:c2

Example 2
Input:  abc1.20f1.345a
Output: ab:c1:20:f1:34:5a


Task 2: Mask Code
Submitted by: Mohammad S Anwar
You are given a list of codes in many random format.

Write a script to mask first four characters (a-z,0-9) and keep the rest as it is.

Example 1
Input: @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy')
Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')

Example 2
Input: @list = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f')
Output: ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')
