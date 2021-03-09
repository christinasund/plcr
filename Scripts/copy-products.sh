#!/bin/sh
set -e

# Clean
rm -rf "$BUILT_PRODUCTS_DIR"
mkdir -p "$BUILT_PRODUCTS_DIR"

# Tools
mkdir -p "$BUILT_PRODUCTS_DIR/Tools"
install -m 755 "$BUILD_DIR/Custom-macosx/plcrashutil" "$BUILT_PRODUCTS_DIR/Tools"

# Universal frameworks
mkdir -p "$BUILT_PRODUCTS_DIR/iOS Framework"
cp -R "$BUILD_DIR/Custom-iphoneuniversal/$PROJECT_NAME.framework" "$BUILT_PRODUCTS_DIR/iOS Framework"

mkdir -p "$BUILT_PRODUCTS_DIR/tvOS Framework"
cp -R "$BUILD_DIR/Custom-appletvuniversal/$PROJECT_NAME.framework" "$BUILT_PRODUCTS_DIR/tvOS Framework"

# Dynamic macOS framework
mkdir -p "$BUILT_PRODUCTS_DIR/Mac OS X Framework"
cp -R "$BUILD_DIR/Custom-macosx/$PROJECT_NAME.framework" "$BUILT_PRODUCTS_DIR/Mac OS X Framework"
cp -R "$BUILD_DIR/Custom-macosx/$PROJECT_NAME.framework.dSYM" "$BUILT_PRODUCTS_DIR/Mac OS X Framework"

# XCFrameowrk
cp -R "$BUILD_DIR/Custom-xcframework/$PROJECT_NAME.xcframework" "$BUILT_PRODUCTS_DIR"

# Static libraries
mkdir -p "$BUILT_PRODUCTS_DIR/Static/include"
cp -R "$BUILD_DIR/Custom-macosx/$PROJECT_NAME.framework/Headers/." "$BUILT_PRODUCTS_DIR/Static/include/"
cp "$BUILD_DIR/Custom-iphoneuniversal/lib$PROJECT_NAME.a" "$BUILT_PRODUCTS_DIR/Static/lib$PROJECT_NAME-iOS.a"
cp "$BUILD_DIR/Custom-appletvuniversal/lib$PROJECT_NAME.a" "$BUILT_PRODUCTS_DIR/Static/lib$PROJECT_NAME-tvOS.a"
cp "$BUILD_DIR/Custom-macosx/lib$PROJECT_NAME.a" "$BUILT_PRODUCTS_DIR/Static/lib$PROJECT_NAME-MacOSX-Static.a"

#### Tealium ###

# Clean
rm -rf "$PROJECT_DIR/iOS Framework"
rm -rf "$PROJECT_DIR/$PROJECT_NAME.xcframework"

# Copy frameworks
cp -R "$BUILD_DIR/Custom/iOS Framework" "$PROJECT_DIR/iOS Framework"
cp -R "$BUILD_DIR/Custom-xcframework/$PROJECT_NAME.xcframework" "$PROJECT_DIR"

# Zip framework
zip -r "Tealium$PROJECT_NAME.framework.zip" "./iOS Framework"

# Remove folder
rm -rf "$PROJECT_DIR/iOS Framework"

