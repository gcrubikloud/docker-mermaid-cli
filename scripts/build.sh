#!/usr/bin/env sh

set -e

MERMAID_OUTPUT_BGCOLOR="${MERMAID_OUTPUT_BGCOLOR:-white}"
MERMAID_OUTPUT_FORMAT="${MERMAID_OUTPUT_FORMAT:-pdf}"
MERMAID_OUTPUT_HEIGHT="${MERMAID_OUTPUT_HEIGHT:-600}"
MERMAID_OUTPUT_THEME="${MERMAID_OUTPUT_THEME:-forest}"
MERMAID_OUTPUT_WIDTH="${MERMAID_OUTPUT_WIDTH:-800}"

for mermaidFile in ${APP_DIRECTORY}/diagram-source/*.mmd; do
    baseName=$(basename "${mermaidFile}" ".mmd")
    echo "Processing ${mermaidFile} to ${APP_DIRECTORY}/diagram-output/${baseName}.${MERMAID_OUTPUT_FORMAT}..."
    /node_modules/.bin/mmdc \
        --backgroundColor "${MERMAID_OUTPUT_BGCOLOR}" \
        --height "${MERMAID_OUTPUT_HEIGHT}" \
        --input "${mermaidFile}" \
        --output "${APP_DIRECTORY}/diagram-output/${baseName}.${MERMAID_OUTPUT_FORMAT}" \
        --theme "${MERMAID_OUTPUT_THEME}" \
        --width "${MERMAID_OUTPUT_WIDTH}"
done
