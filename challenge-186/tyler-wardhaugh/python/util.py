"""Utilities"""

import importlib.util
from pathlib import Path
from types import ModuleType


def import_task(n: int) -> ModuleType:
    """Import a task by number and return the module"""

    filepath: Path = Path(__file__).parent.joinpath(f"ch-{n}.py")
    spec = importlib.util.spec_from_file_location(f"ch{n}", str(filepath))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)

    return module
