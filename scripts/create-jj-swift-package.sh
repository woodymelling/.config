#!/bin/bash
#!/bin/bash
set -euo pipefail

# Check that exactly two parameters are provided.
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <kebab-case-folder> <CamelCaseModuleName>"
  exit 1
fi

FOLDER_NAME="$1"
MODULE_NAME="$2"

# Ensure the directory does not already exist.
if [ -d "$FOLDER_NAME" ]; then
  echo "Error: Directory '$FOLDER_NAME' already exists."
  exit 1
fi

# Create the folder and move into it.
mkdir "$FOLDER_NAME"
cd "$FOLDER_NAME"

# Use swift package init to create the basic structure.
# We supply --name so that the sources and tests directories get created with the module name.
swift package init --type library --name "$MODULE_NAME"

# Overwrite Package.swift with our custom template.
cat <<EOF > Package.swift
// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "$FOLDER_NAME",
    products: [
        .library(name: "$MODULE_NAME", targets: ["$MODULE_NAME"]),
    ],
    targets: [
        .target(name: "$MODULE_NAME"),
        .testTarget(
            name: "${MODULE_NAME}Tests",
            dependencies: ["$MODULE_NAME"]
          ),
    ]
)
EOF

# Initialize a git repository using 'jj' and commit the initial state.
jj git init
jj commit -m "🌱"

echo "Swift package created in folder '$FOLDER_NAME' with module '$MODULE_NAME'."
