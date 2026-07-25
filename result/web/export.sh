#!/usr/bin/env bash
SCRIPT_PATH=$(realpath "${BASH_SOURCE[0]}")

# Move into the repo root
pushd $(dirname $SCRIPT_PATH)/../.. || exit 

# Clean before build
find result/web -type f -name 'gmtk_2026.*' -delete
rm result/web/web.zip

# Build and zip
godot --export-debug Web result/web/gmtk_2026.html
mv result/web/gmtk_2026.html result/web/index.html
zip -r result/web/web.zip result/web/gmtk_2026* result/web/index.html
echo "Final build at: $(pwd)/result/web/web.zip"

popd
