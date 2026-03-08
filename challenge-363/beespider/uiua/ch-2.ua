# uiua 0.18.0

# Boolean ? Address Domain
SubnetSheriff ← |2 ⍣(
  ∩⋕₁₀⊓{°$"_._._._"}{°$"_._._._/_"}    # Parse the address and domain into number arrays
  ⊙⊃↙₄⊣                                # Split off the prefix length from the numbers in the domain
  ˙⍤×◡⊓(×∩(/×××⊃⊃≥₀≤₂₅₅(=⊸⌊))|×⊃≥₀≤₃₂) # Assert that all the numbers are in range and that the numbers in the address and domain are integers
  ≍ ∩⌟˜↙ ∩(/⊂≡⇌⋯₈)                     # Convert the address and domain to bits and determine whether the prefixes match
)0                                     # Return 0 (0) if parsing or assertions fail

┌─╴test
  ⍤⤙≍ 1 SubnetSheriff "192.168.1.45" "192.168.1.0/24"
  ⍤⤙≍ 0 SubnetSheriff "10.0.0.256" "10.0.0.0/24"
  ⍤⤙≍ 1 SubnetSheriff "172.16.8.9" "172.16.8.9/32"
  ⍤⤙≍ 1 SubnetSheriff "172.16.4.5" "172.16.0.0/14"
  ⍤⤙≍ 1 SubnetSheriff "192.0.2.0" "192.0.2.0/25"
└─╴