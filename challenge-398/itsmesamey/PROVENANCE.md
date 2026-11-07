# Provenance

The two problems and ten official examples come from [The Weekly Challenge 398](https://theweeklychallenge.org/blog/perl-weekly-challenge-398/), published November 2, 2026. No current participant solution was read or copied.

The Perl solutions, transport code and documentation were generated with OpenAI Codex assistance under the pseudonym ItsMeSamey. A separate AI agent froze the Python oracle before inspecting the solutions, then reviewed the source and retained native results. The oracle uses exact `Fraction` distances for the nearest-integer set and groups complete adjacent-difference tuples for the exceptional-word result.

The solution scripts are byte-identical to the validated originals. The oracle's calculations and case definitions are unchanged; its Python formatting and docstrings now follow the repository checks. The runners have the same comparison logic, with explicit missing-module/helper guards, documentation, formatting and scoped subprocess-review comments. The batch transport adds POD documentation and two scoped lint comments for its runtime-selected script paths; its executable code is unchanged. `verification/reproduce.py` supplies portable paths and manifests to those runners, and `verification/CLI_SELECTION.json` retains the original thirteen CLI cases. `PACKAGE_MANIFEST.json` pins the public files; `VERIFICATION.json` distinguishes original tested hashes from the revised public sources.

The MIT license covers this original code and documentation. Perl, Python and their standard libraries retain their own licenses and are not redistributed here.
