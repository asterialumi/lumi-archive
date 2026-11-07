# MSYS2 Setup (C & C++)

This guide details setting up the native GCC/G++ UCRT64 toolchain on Windows for building and debugging C23 and C++23 (or later).

> *will document how to update the compiler versions later.*


## 1. Installation

1. Download and run the installer from [msys2.org](https://www.msys2.org/).
2. Install to the default directory (`C:\msys64`). **I RECOMMEND FOLLOWING THIS**.
3. When finished, open the **MSYS2 UCRT64** terminal from the Start Menu.


## 2. Toolchain Packages

Run the following command in the UCRT64 terminal:

```bash
pacman -S --needed base-devel mingw-w64-ucrt-x86_64-toolchain
```

- When prompted to select packages (`Enter a selection`), press **Enter** to select all defaults.
- When prompted to proceed with installation (`Y/n`), type **`y`** and press **Enter**.

*(Note: If a download times out or fails, rerun the exact same command to resume where it left off).*


## 3. Environment Variables (PATH)

To use the compiler and tools directly from VS Code or PowerShell/CMD:

1. Press `Win + S`, search for **"Edit the system environment variables"**, and open it.
2. Click **Environment Variables...** at the bottom right.
3. Under **User variables** (or **System variables**), select `Path` and click **Edit...**.
4. Click **New** and add the following two paths:
   - `C:\msys64\ucrt64\bin` *(Contains gcc, g++, gdb)*
   - `C:\msys64\usr\bin` *(Contains bash, cygpath, core Linux tools)*
5. Click **OK** on all dialog boxes to save.


## 4. Verification

Restart any open terminal or CMD window, then verify the installation:

```bash
gcc --version
g++ --version
gdb --version
bash --version
```

If all commands return version numbers without errors, the environment is ready.


## 5. Extensions & VS Code Alignment

Download the `ms-vscode.cpptools-extension-pack` extension for general C/C++ capabilities and workspace configurations in `.vscode` to work.

If MSYS2 was installed to a non-default location (not `C:\msys64`), update the absolute paths in the following `.vscode` files to match the custom path:
- `.vscode/c_cpp_properties.json` (`compilerPath`)
- `.vscode/launch.json` (`miDebuggerPath`)
- `.vscode/tasks.json` (`command` and `PATH` env)