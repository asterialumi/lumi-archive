# Recommended Extensions

This document details the extensions used in this workspace. Some of these extensions are pinned in `.vscode/extensions.json` so that opening this repository prompts for automatic one-click installation.




| Category | Extension | Extension ID | Purpose / Notes |
| :--- | :--- | :--- | :--- |
| **C / C++** | C/C++ Extension Pack | `ms-vscode.cpptools-extension-pack` | Bundles IntelliSense, code navigation, GDB debugging bridge, and CMake/formatting tools. |
| **Python** | Python | `ms-python.python` | Core python language server, interactive interpreter switching, and debugger integration. |
| **Python** | Ruff | `charliermarsh.ruff` | High-performance linter and code formatter. Handles automatic PEP 8 styling and import organization on save. |


## Installation via CLI (Optional)

If configuring an environment headlessly or from a command terminal, all workspace extensions can be installed using:

```bash
code --install-extension ms-vscode.cpptools-extension-pack
code --install-extension ms-python.python
code --install-extension charliermarsh.ruff
```