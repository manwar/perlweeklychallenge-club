<!--
SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
SPDX-License-Identifier: BSD-2-Clause
-->

# Parse a mini-language for selecting objects by tag or name

\[[Home][ringlet-parse-stages] | [GitLab][gitlab] | [PyPI][pypi] | [ReadTheDocs][readthedocs]\]

## Overview

The `parse-stages` Python library may be used by other tools to group
objects (e.g. [Tox] or [Nox] test environments) for step-by-step processing
(e.g. running some tests in parallel, then only running others if the first
group passes).

The language used by the library is described in the
[_Grouping stages_](language.md#grouping-stages-for-step-by-step-execution)
section.

[tox]: https://tox.wiki/en/latest/ "The tox automation project"
[nox]: https://nox.thea.codes/en/stable/ "The nox flexible automation tool"

## Installation

A program that uses the `parse-stages` library should specify it in
its list of requirements, e.g. using [PEP508][pep508] syntax:

    parse-stages >= 0.1.9, < 0.2

[pep508]: https://peps.python.org/pep-0508/ "PEP 508 – Dependency specification for Python Software Packages"

## Parsing a stage specification

The `parse_spec()` function parses a string specification into
a [BoolExpr][parse_stages.BoolExpr] object that may later be used to
select matching objects (e.g. test environments).

``` py
    e_check = parse_stages.parse_spec("@check")
    e_check_quick = parse_stages.parse_spec("@check and @quick")
    e_check_no_ruff = parse_stages.parse_spec("@check and not ruff")
    
    specs = [(spec, parse_stages.parse_spec(spec)) for spec in args.stage_specs]
```

## Check whether an object matches a parsed specification

The `parse-stages` library provides two base dataclasses for objects that
may be matched against parsed expressions:
[TaggedFrozen][parse_stages.TaggedFrozen] and [Tagged][parse_stages.Tagged].
Both classes have the same members:

- [name][parse_stages.TaggedFrozen.name]: a string
- [tags][parse_stages.TaggedFrozen.tags]: a list of strings
- [get_keyword_haystacks()][parse_stages.TaggedFrozen.get_keyword_haystacks]:
  a method that returns a list of strings,
  `self.name` unless overridden

When a `BoolExpr` object's [evaluate()][parse_stages.BoolExpr.evaluate]
method is called for a specific
`TaggedFrozen` or `Tagged` object, it checks whether the specification
matches the tags and keywords defined for this object. Tags are matched
exactly, while a keyword is considered to match if it is contained in
the checked string; e.g. `pep` would match both `pep8` and `exp_pep563`,
while `@black` would not match a `black-reformat` tag.

The `get_keyword_haystacks()` method returns the strings to look in for
matching keywords. By default, it only returns the `name` field;
however, it may be extended, e.g. for Nox sessions it may also return
the name of the Python function that implements the session, for test
classes with methods it may return the class name and the method name, etc.

``` py
    # Obtain a list (okay, a dictionary) of test environments in some way
    tox_envs = get_tox_environments()  # {"ruff": {"tags": ["check", "quick"]}, ...}

    # Convert them to objects that the parsed expressions can match
    all_envs = [
        parse_stages.TaggedFrozen(name, env["tags"])
        for name, env in tox_envs.items()
    ]

    # Or define our own class that may hold additional information
    @dataclasses.dataclass(frozen=True)
    class TestEnv(parse_stages.TaggedFrozen):
        """A single test environment: name, tags, etc."""
        ...

    all_envs = [TestEnv(name, env["tags"], ...) for name, env in tox_envs.items()]

    # Select the ones that match the "@check" expression
    matched = [env for env in all_envs if e_check.evaluate(env)]

    # Or if we only care about the names...
    quick_names = [env.name for env in all_envs if e_check_quick.evaluate(env)]
```

## Contact

The `parse-stages` library was written by [Peter Pentchev][roam].
It is developed in [a GitLab repository][gitlab]. This documentation is
hosted at [Ringlet][ringlet-parse-stages] with a copy at [ReadTheDocs][readthedocs].

[roam]: mailto:roam@ringlet.net "Peter Pentchev"
[gitlab]: https://gitlab.com/ppentchev/parse-stages "The parse-stages GitLab repository"
[pypi]: https://pypi.org/project/parse-stages/ "The parse-stages Python Package Index page"
[readthedocs]: https://parse-stages.readthedocs.io/ "The parse-stages ReadTheDocs page"
[ringlet-parse-stages]: https://devel.ringlet.net/devel/parse-stages/ "The Ringlet parse-stages homepage"
