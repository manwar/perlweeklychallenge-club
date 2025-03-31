#!/bin/sh
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

set -e

echo '=== shellcheck'
shellcheck format.sh run-tests.sh

echo '=== format check'
./format.sh check

echo '=== prove'
prove ch-*.t
