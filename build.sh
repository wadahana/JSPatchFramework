#!/bin/bash

FRAMEWORK_NAME=JSPatch
FRAMEWORK_VERSION=A
FRAMEWORK_CURRENT_VERSION=0.9
FRAMEWORK_COMPATIBILITY_VERSION=0.9
BUILD_TYPE=Release


# build
xcodebuild -configuration Release -target "JSPatch" -sdk iphoneos
xcodebuild -configuration Release -target "JSPatch" -sdk iphonesimulator


# package

# This is the full name of the framework we'll  build
FRAMEWORK_DIR=$FRAMEWORK_NAME.framework

# Clean any existing framework that might be there already
echo "Framework: Cleaning framework..."
[ -d "$FRAMEWORK_DIR" ] && \
  rm -rf "$FRAMEWORK_DIR"

# Build the canonical Framework bundle directory structure
echo "Framework: Setting up directories..."
mkdir -p $FRAMEWORK_DIR
mkdir -p $FRAMEWORK_DIR/Versions
mkdir -p $FRAMEWORK_DIR/Versions/$FRAMEWORK_VERSION
mkdir -p $FRAMEWORK_DIR/Versions/$FRAMEWORK_VERSION/Resources
mkdir -p $FRAMEWORK_DIR/Versions/$FRAMEWORK_VERSION/Headers

echo "Framework: Creating symlinks..."
ln -s $FRAMEWORK_VERSION $FRAMEWORK_DIR/Versions/Current
ln -s Versions/Current/Headers $FRAMEWORK_DIR/Headers
ln -s Versions/Current/Resources $FRAMEWORK_DIR/Resources
ln -s Versions/Current/$FRAMEWORK_NAME $FRAMEWORK_DIR/$FRAMEWORK_NAME

# Check that this is what your static libraries are called
FRAMEWORK_INPUT_ARM_FILES="build/$BUILD_TYPE-iphoneos/lib$FRAMEWORK_NAME.a"
FRAMEWORK_INPUT_I386_FILES="build/$BUILD_TYPE-iphonesimulator/lib$FRAMEWORK_NAME.a"


echo "Framework: Creating library..."

lipo -create \
  "$FRAMEWORK_INPUT_ARM_FILES" \
  "$FRAMEWORK_INPUT_I386_FILES" \
  -output "$FRAMEWORK_DIR/Versions/Current/$FRAMEWORK_NAME"


# Now copy the final assets over: your library
# header files and the plist file
echo "Framework: Copying assets into current version..."

cp JSPatch/JPEngine.h $FRAMEWORK_DIR/Headers/
