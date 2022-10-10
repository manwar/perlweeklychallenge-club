a‿b←10‿20
file←"relative/path/to/file.txt"

((a⊸≤∧b⊸≥)∘↕∘≠/⊢)•FLines file
