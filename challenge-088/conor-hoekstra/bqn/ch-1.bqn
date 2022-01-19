# Two Suboptimal Solutions
Solution ← ×´¨1↓¨(↕∘≠)⌽¨<     # Using rotates
Solution ← ×´¨(<˘≠⌜˜∘↕∘≠)/¨<  # Using filters (replicates)

# The Actual Solution
Solution ← ×´÷⊢

# Tests 
Solution 5‿2‿1‿4‿3  # ⟨ 24 60 120 30 40 ⟩
Solution 2‿1‿4‿3    # ⟨ 12 24 6 8 ⟩

# Alternative Solution (that works for 0s)

PreScan          ← ×`¯1↓1∾⊢
ArraryOfProducts ← PreScan⌾⌽ × PreScan

ArraryOfProducts 5‿2‿1‿4‿3 # ⟨ 24 60 120 30 40 ⟩
ArraryOfProducts 2‿1‿4‿3    # ⟨ 12 24 6 8 ⟩ 
ArraryOfProducts 5‿2‿0‿4‿3 # ⟨ 0 0 120 0 0 ⟩
ArraryOfProducts ⟨⟩            # ⟨⟩
