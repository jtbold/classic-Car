#!/bin/bash
set -e

echo "================================"
echo "  Classic Iron — Build Script"
echo "================================"
echo ""

# Validate env var
echo "Validating environment..."
if [ -z "$GEMINI_API_KEY" ]; then
  echo "ERROR: GEMINI_API_KEY not set."
  echo "Add it in the Render dashboard: Environment tab."
  exit 1
fi
echo "GEMINI_API_KEY found (${#GEMINI_API_KEY} chars)"
echo ""

# Validate source file
if [ ! -f "classic-car-analyzer.html" ]; then
  echo "ERROR: classic-car-analyzer.html not found in repo root."
  exit 1
fi
echo "Source file found."

# Inject key and write index.html
echo "Injecting API key..."
sed "s|<!-- GEMINI_KEY_INJECT -->|<script>var __gemini_api_key = \"$GEMINI_API_KEY\";<\/script>|g" \
  classic-car-analyzer.html > index.html

# Verify
if grep -q "__gemini_api_key" index.html; then
  echo "API key injected successfully."
else
  echo "ERROR: Injection failed. Check the GEMINI_KEY_INJECT placeholder in the HTML."
  exit 1
fi

echo ""
echo "================================"
echo "  Build complete -> index.html"
echo "================================"
