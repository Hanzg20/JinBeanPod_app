#!/bin/bash

# Find all xcconfig files related to gRPC
find ./Pods -name "*.xcconfig" | while read -r file; do
    if [[ $file == *"gRPC"* ]] || [[ $file == *"BoringSSL"* ]] || [[ $file == *"abseil"* ]]; then
        # Remove -G flag from the file
        sed -i '' 's/-G[[:space:]]*//g' "$file"
        echo "Processed $file"
    fi
done

# Find all build settings files
find ./Pods -name "*.pbxproj" | while read -r file; do
    # Remove -G flag from build settings
    sed -i '' 's/-G[[:space:]]*//g' "$file"
    echo "Processed $file"
done 