#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 363-2,
written by Robbie Hatley on Tue Mar 3, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 363-2: Subnet Sheriff
Submitted by: Peter Campbell Smith
You are given an IPv4 address and an IPv4 network (in CIDR
format). Write a script to determine whether both are valid and
the address falls within the network. For more information, see
this Wikipedia article:
https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing

Examples:
(
   # Example #1:
   [
      "192.168.1.45",
      "192.168.1.0/24",
   ],
   # Expected output: true

   # Example #2:
   [
      "10.0.0.256",
      "10.0.0.0/24",
   ],
   # Expected output: false

   # Example #3:
   [
      "172.16.8.9",
      "172.16.8.9/32",
   ],
   # Expected output: true

   # Example #4:
   [
      "172.16.4.5",
      "172.16.0.0/14",
   ],
   # Expected output: true

   # Example #5:
   [
      "192.0.2.0",
      "192.0.2.0/25",
   ],
   # Expected output: true
);

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll first check that the two IP addresses are valid (4 dot-separated positive decimal integers in the 0-255
range), then check that the subnet is valid (a positive decimal integer in the 0-32 range). Then check that
the "$ip_addr" is in the range of the "$domain" by converting the two IP addresses to integer, then making
the subnet mask correspoding to the bitcount, then bitwise-anding the mask against the two addresses and
seeing if the results match.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted strings, with each First string being an IP Address and
each Second string being a Gateway address with subnet bit count, in proper Perl syntax, like so:

./ch-2.pl '(["192.168.42.217", "192.168.42.0/24"],["192.168.183.131", "192.168.183.127/25"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Subnet Sheriff:
   sub subnet_sheriff ( $ipa, $gwa ) { # $ipa = IP Address. $gwa = GateWay Address.
      if ($ipa !~ m/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/) {
         say "Malformed IP address.";
         return;
      }
      my ($ipb1, $ipb2, $ipb3, $ipb4) = (0+$1, 0+$2, 0+$3, 0+$4);
      say "IP = $ipb1.$ipb2.$ipb3.$ipb4";
      if ($gwa !~ m/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\/(\d{1,2})$/) {
         say "Malformed Gateway address.";
         return;
      }
      my ($gwb1, $gwb2, $gwb3, $gwb4, $gwsn) = (0+$1, 0+$2, 0+$3, 0+$4, 0+$5);
      say "GW = $gwb1.$gwb2.$gwb3.$gwb4/$gwsn";
      # We've forced all nine numbers to be non-negative integers. Now check that
      # the 8 bytes are no-greater-than 255 and the bit count is no-greater-than 32:
      if (    $ipb1 > 255 || $ipb2 > 255 || $ipb3 > 255 || $ipb4 > 255
           || $gwb1 > 255 || $gwb2 > 255 || $gwb3 > 255 || $gwb4 > 255
           || $gwsn > 32) {
              say "One or more numbers are out-of-bounds.";
              return;
         }
      my $ipint = ($ipb1 << 24) + ($ipb2 << 16) + ($ipb3 << 8) + $ipb4;
      my $gwint = ($gwb1 << 24) + ($gwb2 << 16) + ($gwb3 << 8) + $gwb4;
      say "\$ipint = $ipint";
      say "\$gwint = $gwint";
      my $mask  = 4294967295 & (4294967295 << (32 - $gwsn));
      printf("SM = %032b\n", $mask);
      my $ipand = $ipint & $mask;
      my $gwand = $gwint & $mask;
      say "\$ipint & \$mask = $ipand";
      say "\$gwint & \$mask = $gwand";
      if ($ipand == $gwand) {
         say "IP address matches Gateway address and mask.";
      }
      else {
         say "IP address does NOT match Gateway address and mask.";
      }
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1:
   [
     "192.168.1.45",
     "192.168.1.0/24",
   ],
   # Expected output: true

   # Example #2:
   [
      "10.0.0.256",
      "10.0.0.0/24",
   ],
   # Expected output: false

   # Example #3:
   [
      "172.16.8.9",
      "172.16.8.9/32",
   ],
   # Expected output: true

   # Example #4:
   [
      "172.16.4.5",
      "172.16.0.0/14",
   ],
   # Expected output: true

   # Example #5:
   [
      "192.0.2.0",
      "192.0.2.0/25",
   ],
   # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $ipa = $aref->[0];
   my $gwa = $aref->[1];
   subnet_sheriff($ipa, $gwa);
}
