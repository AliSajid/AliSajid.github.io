#!/bin/bash

# Enable debugging
set -x

# Initialize variable to track if any changes were made
CHANGES_TO_PUBLISH=false

# Find all Markdown files and read them into an array
mapfile -t files < <(find ./content -name "*.md")

# Loop over the array
for file in "${files[@]}"; do
    echo "Processing file: $file"

    # Check if the file is a draft
    if grep -q 'draft: true' "$file"; then
        echo "Found draft: $file"

        # Extract the publish date
        publish_date=$(grep -Po '(?<=date: ).*' "$file")
        publish_date=$(date -d "$publish_date" +%s)
        current_date=$(date +%s)

        # Check if the publish date is in the past
        if [ "$publish_date" -le "$current_date" ]; then
            echo "Publish date is in the past for: $file"

            # Set draft status to false
            sed -i 's/draft: true/draft: false/' "$file"
            echo "Set draft status to false for: $file"

            # Mark that changes were made
            CHANGES_TO_PUBLISH=true
        else
            echo "Publish date is in the future for: $file"
        fi
    else
        echo "Not a draft: $file"
    fi
done

# Check if any changes were made
if [ "$CHANGES_TO_PUBLISH" = true ]; then
    echo "Changes were made. Publishing drafts..."
    echo "CHANGES_TO_PUBLISH=true" >> "$GITHUB_ENV"
else
    echo "No drafts need to be published."
fi

# Disable debugging
set +x
