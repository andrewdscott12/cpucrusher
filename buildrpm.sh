#!/bin/bash
set -e

# Build RPM package for cpucrusher
# This script creates the source tarball and triggers rpmbuild
# Automatically detects AIX or Linux and uses the appropriate spec file

VERSION="1.0"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMP_DIR=$(mktemp -d)
TARBALL_NAME="cpucrusher-${VERSION}.tar.gz"

# Detect OS and select appropriate spec file
OS_TYPE=$(uname -s)
if [ "$OS_TYPE" = "AIX" ]; then
    echo IBM AIX Detected
    SPEC_FILE="cpucrusher.aix.spec"
    OS_NAME="AIX"
elseif [ "$OS_TYPE" = "Linux" ]; then
    echo Linux Detected
    SPEC_FILE="cpucrusher.spec"
    OS_NAME="Linux"
else
    echo "Unsupported OS: $OS_TYPE"
    exit 1
fi

trap "rm -rf ${TEMP_DIR}" EXIT

echo "Building for: $OS_NAME"
echo "Using spec file: $SPEC_FILE"
echo "Creating source tarball for cpucrusher v${VERSION}..."

# Create project structure in temp directory
mkdir -p "${TEMP_DIR}/cpucrusher-${VERSION}"

# Copy source files
cp "${PROJECT_DIR}/cpucrusher.c" "${TEMP_DIR}/cpucrusher-${VERSION}/"
cp "${PROJECT_DIR}/Makefile" "${TEMP_DIR}/cpucrusher-${VERSION}/"
cp "${PROJECT_DIR}/${SPEC_FILE}" "${TEMP_DIR}/cpucrusher-${VERSION}/"
cp "${PROJECT_DIR}/README.md" "${TEMP_DIR}/cpucrusher-${VERSION}/"

# Copy debian directory if it exists
if [ -d "${PROJECT_DIR}/debian" ]; then
    cp -r "${PROJECT_DIR}/debian" "${TEMP_DIR}/cpucrusher-${VERSION}/"
fi

# Create tarball in SOURCES directory
mkdir -p ~/rpmbuild/SOURCES
cd "${TEMP_DIR}"
tar czf ~/rpmbuild/SOURCES/${TARBALL_NAME} cpucrusher-${VERSION}/

echo "Source tarball created: ~/rpmbuild/SOURCES/${TARBALL_NAME}"
echo ""
echo "Building RPM package..."

# Run rpmbuild with the appropriate spec file
rpmbuild -ba "${PROJECT_DIR}/${SPEC_FILE}"

echo ""
echo "RPM build complete!"
echo "Check ~/rpmbuild/RPMS/ for binary packages"
echo "Check ~/rpmbuild/SRPMS/ for source package"
