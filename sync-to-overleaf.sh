#!/bin/bash

# === Configuration ===
PROJECT_DIR="$HOME/work/dissertation/thesis"
ZIP_NAME="thesis-overleaf.zip"
OVERLEAF_URL="https://www.overleaf.com/project/6818ec975a574d326c59f6a9"

# === Change to the LaTeX project directory ===
cd "$PROJECT_DIR" || { echo "Project directory not found!"; exit 1; }

# === Create a ZIP archive excluding build files ===
zip -r "$ZIP_NAME" . \
  -x "*.aux" "*.log" "*.out" "*.toc" "*.lof" "*.lot" "*.gz" "*.bbl" "*.blg" "*.fdb_latexmk" "*.fls" "*.synctex.gz" "*.pdf"

echo "Zipped project to: $ZIP_NAME"

# === Open Overleaf project in default browser ===
xdg-open "$OVERLEAF_URL" >/dev/null 2>&1 &

echo "Overleaf project opened in browser. Please upload '$ZIP_NAME' manually."
