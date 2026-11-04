
#!/usr/bin/env bash

# PURPOSE
# Builds the active C or C++ source file into an executable.
#
# HOW IT WORKS
# - .c               -> GCC (C23)
# - .cpp, .cc, .cxx  -> G++ (C++23)
# - Adds debug symbols with -g.
# - Links libstdc++exp for the current std::print setup.
#
# USED BY
# tasks.json, which calls this script before running/debugging.


set -e

extension="$1"
source_file="$(cygpath -u "$2")"
output_file="$(cygpath -u "$3")"

# Create the output directory if necessary.
mkdir -p "$(dirname "$output_file")"

echo "Building $source_file (extension: $extension)"
case "$extension" in
    .c)
        echo "Compiler: GCC (C)"
        /ucrt64/bin/gcc.exe \
            -std=c23 \
            -g \
            -fdiagnostics-color=always \
            "$source_file" \
            -o "$output_file"
        ;;

    .cpp|.cc|.cxx)
        echo "Compiler: G++ (C++)"
        /ucrt64/bin/g++.exe \
            -std=c++23 \
            -g \
            -fdiagnostics-color=always \
            "$source_file" \
            -lstdc++exp \
            -o "$output_file"
        ;;

    *)
        echo "Unsupported file extension: $extension" >&2
        exit 1
        ;;
esac
