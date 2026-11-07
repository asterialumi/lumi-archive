# Python Setup

This guide details setting up an isolated Python workspace on Windows using virtual environments (`.venv`).

## 1. Installation

1. Download and run the installer for Python 3.12 (or later) from [python.org](https://www.python.org/).
2. **Important:** On the first installer screen, check the box that says **"Add python.exe to PATH"**.
3. Complete the installation using the default options.


## 2. Extensions

Install the following extensions from the VS Code Marketplace:
- **Python** (`ms-python.python`) — Core language support and debugging.
- **Ruff** (`charliermarsh.ruff`) — Ultra-fast linter and formatter.

These are required for general python and [python] settings in `.vscode/settings.json` to work.


## 3. Virtual Environment Creation

Create a workspace-level virtual environment at the root of the repository to prevent polluting the global system Python:

1. Open a terminal in VS Code at the workspace root.
2. Run the following command:

```powershell
python -m venv .venv
```

3. Ensure `.gitignore` contains `.venv/` so the isolated packages are never tracked by Git.


## 4. Interpreter Selection

Point VS Code to use the newly created virtual sandbox:

1. Press `Ctrl + Shift + P` to open the Command Palette.
2. Search for and select: **`Python: Select Interpreter`**.
3. Choose the entry marked with the workspace tag:
```text
Python 3.12.x ('.venv': venv) .\.venv\Scripts\python.exe
```

*(Note: Do not select interpreters inside `C:\msys64\ucrt64\bin\`. Those belong internally to MSYS2/GDB).*


## 5. Execution Policy & Profile Shortcut

To enable clean, manual environment switching via an `activate` shortcut:

### Step A: Allow Local Script Execution
1. Open Windows PowerShell as **Administrator**.
2. Run the following command:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

3. Type **`y`** and press **Enter** to confirm, then close the administrator window.

### Step B: Add the Profile Shortcut
1. Open a standard terminal or PowerShell and open the user profile configuration:

```powershell
notepad $PROFILE
```

*If it says that the file doesn't exist, do this before the command above:*

```powershell
New-Item -Path $PROFILE -Type File -Force
```

2. Paste the following function at the bottom of the file:

```powershell
function activate {
    if (Test-Path ".\.venv\Scripts\Activate.ps1") {
        & ".\.venv\Scripts\Activate.ps1"
    } else {
        Write-Host "No .venv found in current directory." -ForegroundColor Yellow
    }
}
```

3. Save (`Ctrl + S`) and exit Notepad.


## 6. Verification

Restart the VS Code terminal and verify the manual workflow:

1. Type **`activate`** and press **Enter**. The prompt should now display `(.venv)` in green.
2. Check that Python resolves to the sandbox:

```powershell
Get-Command python
```

The output should point to:
`...\.venv\Scripts\python.exe`

3. Type **`deactivate`** to safely return to standard PowerShell.