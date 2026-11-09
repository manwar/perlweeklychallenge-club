# Verification

The original sealed sources passed 13,146 batch cases and 13 direct CLI checks. A separate AI agent audited the raw outputs against the frozen oracle, including exact string values, request order, error records and process exit status. The public verification files include subsequent documentation, formatting and explicit loading guards while retaining the same oracle calculations, cases and comparison logic. `VERIFICATION.json` distinguishes the original execution evidence and hashes from the revised public sources.

The batch contains:

| Cases | Coverage |
| ---: | --- |
| 10 | Official examples |
| 9,330 | Every array of lengths 1 through 5 over [1,2,3,6,12,18] |
| 3,762 | Every promised-valid ordered triple of words over abc, for word lengths 2 and 3 |
| 5 | Rounding and no-qualifier boundaries |
| 10 | Exact decimal cases around binary64, signed/unsigned 64-bit and 100-digit values |
| 12 | Fixed word cases, including negative differences, duplicates, long strings and outlier positions |
| 4 | Declared empty/leading-zero/ASCII extensions |
| 13 | Declared structural rejections |

The CLI checks use the ten official examples, the retained 100-digit midpoint, and one error path per script. They require exact stdout, stderr and exit status. Extension and rejection cases are labelled separately in the oracle; they are not additional official task rules.

## Local reproduction

From this directory, run:

```sh
python3 -I -S -B verification/reproduce.py --output /tmp/weekly398-checks
```

The output directory must be new. `--perl /path/to/perl` selects an interpreter; `--cpu N` optionally selects an allowed processor. The wrapper otherwise uses Perl from PATH and the first allowed CPU. It verifies package hashes, generates local manifests, calls the batch runner, then checks the same thirteen CLI cases from that batch's oracle data.

The caller supplies trusted local executables and manifests. Hashes identify the selected bytes; they do not authenticate an executable. Each child receives an argument list without a shell.

These retained runners require Linux `/proc` and standard Python modules. They use one CPU, wall-time guards and a 256 MiB sampled aggregate RSS guard. Sampling does not establish an absolute memory peak. A timeout or guard failure produces a failed receipt for inspection. Raw channels, per-case outcomes and native version information remain in the chosen output directory.

`REPRODUCTION.json` reports the combined outcome. A successful run requires all 13,146 batch checks, all 13 CLI checks and zero failing driver exits. The finite cases do not cover arbitrary invalid unique-minority promises or Unicode beyond the declared ASCII domain.
