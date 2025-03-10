# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

set -e
set -x

rm -rf .venv
uvoxen uv run -- -vv

uvoxen -p supported uv run -e mypy,unit-tests -- -vv

if [ -n "$RUN_UVOXEN_TOX_STAGES" ]; then
	"$RUN_UVOXEN_TOX_STAGES" run
fi

rm -rf .venv
uv sync --exact
