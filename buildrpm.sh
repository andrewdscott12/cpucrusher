#!/bin/bash
set -e

# Build RPM package for cpucrusher
# This script creates the source tarball and triggers rpmbuild

VERSION="1.0"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMP_DIR=$(mktemp -d)
TARBALL_NAME="cpucrusher-${VERSION}.tar.gz"

trap "rm -rf ${TEMP_DIR}" EXIT

echo "Creating source tarball for cpucrusher v${VERSION}..."

# Create project structure in temp directory
mkdir -p "${TEMP_DIR}/cpucrusher-${VERSION}"

# Copy source files
cp "${PROJECT_DIR}/cpucrusher.c" "${TEMP_DIR}/cpucrusher-${VERSION}/"
cp "${PROJECT_DIR}/Makefile" "${TEMP_DIR}/cpucrusher-${VERSION}/"
cp "${PROJECT_DIR}/cpucrusher.spec" "${TEMP_DIR}/cpucrusher-${VERSION}/"
cp "${PROJECT_DIR}/README.md" "${TEMP_DIR}/cpucrusher-${VERSION}/"

# Copy debian directory
cp -r "${PROJECT_DIR}/debian" "${TEMP_DIR}/cpucrusher-${VERSION}/"

# Create tarball in SOURCES directory
mkdir -p ~/rpmbuild/SOURCES
cd "${TEMP_DIR}"
tar czf ~/rpmbuild/SOURCES/${TARBALL_NAME}

echo "Source tarball created: ~/rpmbuild/SOURCES/${TARBALL_NAME}"
echo ""
echo "Building RPM package..."

# Run rpmbuild
rpmbuild -ba "${PROJECT_DIR}/cpucrusher.spec"

echo ""
echo "RPM build complete!"
echo "Check ~/rpmbuild/RPMS/ for binary packages"
echo "Check ~/rpmbuild/SRPMS/ for source package"
