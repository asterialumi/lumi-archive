#!/usr/bin/env bash

# PURPOSE
# Builds the active C or C++ source file (and any sibling source files) into an executable.
#
# HOW IT WORKS
# - .c               -> GCC (C23)
# - .cpp, .cc, .cxx  -> G++ (C++23)
# - Adds debug symbols with -g.
# - Enables strict warnings (-Wall, -Wextra, -pedantic).
# - Automatically compiles sibling sources in the same folder.
# - Links libstdc++exp for std::print.
#
# USED BY
# tasks.json, which calls this script before running/debugging.


set -euo pipefail

extension="$1"
source_file="$(cygpath -u "$2")"
output_file="$(cygpath -u "$3")"

# Ensure output directory exists
mkdir -p "$(dirname "$output_file")"

# Detect sibling source files in the same directory (e.g., helper modules, class definitions)
dir_path="$(dirname "$source_file")"
base_name="$(basename "$source_file")"

# Read extra sources into a Bash array safely
extra_sources=()
while IFS= read -r file; do
    [[ -n "$file" ]] && extra_sources+=("$file")
done < <(find "$dir_path" -maxdepth 1 -name "*$extension" ! -name "$base_name")

# Common compiler flags
FLAGS=(-g -Wall -Wextra -pedantic -fdiagnostics-color=always)

echo "Building target: $source_file"
if [ ${#extra_sources[@]} -gt 0 ]; then
    echo "Including sibling sources:"
    printf ' - %s\n' "${extra_sources[@]}"
fi

case "$extension" in
    .c)
        echo "Compiler: GCC (C23)"
        gcc -std=c23 "${FLAGS[@]}" "$source_file" "${extra_sources[@]}" -o "$output_file"
        ;;

    .cpp|.cc|.cxx)
        echo "Compiler: G++ (C++23)"
        g++ -std=c++23 "${FLAGS[@]}" "$source_file" "${extra_sources[@]}" -lstdc++exp -o "$output_file"
        ;;

    *)
        echo "Unsupported file extension: $extension" >&2
        exit 1
        ;;
esac

echo "Build successful -> $output_file"