#!/bin/bash

# Ionic Angular Android Build Script
# This script automates the entire process of building an Android APK

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."

    if ! command_exists node; then
        print_error "Node.js is not installed. Please install Node.js first."
        exit 1
    fi

    if ! command_exists npm; then
        print_error "npm is not installed. Please install npm first."
        exit 1
    fi

    if ! command_exists ionic; then
        print_warning "Ionic CLI not found globally. Installing..."
        npm install -g @ionic/cli
    fi

    print_success "Prerequisites check completed"
}

# Function to install dependencies
install_dependencies() {
    print_status "Installing project dependencies..."
    npm install
    print_success "Dependencies installed"
}

# Function to add Android platform if not exists
add_android_platform() {
    if [ ! -d "android" ]; then
        print_status "Adding Android platform..."
        ionic capacitor add android
        print_success "Android platform added"
    else
        print_status "Android platform already exists"
    fi
}

# Function to build web assets
build_web_assets() {
    print_status "Building web assets for production..."
    ionic build --prod
    print_success "Web assets built successfully"
}

# Function to sync Capacitor
sync_capacitor() {
    print_status "Syncing Capacitor with Android project..."
    ionic capacitor sync android
    print_success "Capacitor sync completed"
}

# Function to build Android APK
build_android_apk() {
    print_status "Building Android APK..."
    ionic capacitor build android

    # Check if APK was created
    APK_PATH="android/app/build/outputs/apk/debug/app-debug.apk"
    if [ -f "$APK_PATH" ]; then
        print_success "APK built successfully!"
        print_status "APK location: $APK_PATH"

        # Get APK size
        APK_SIZE=$(du -h "$APK_PATH" | cut -f1)
        print_status "APK size: $APK_SIZE"

        # Copy APK to project root for easy access
        cp "$APK_PATH" "./app-debug.apk"
        print_success "APK copied to project root as 'app-debug.apk'"
    else
        print_error "APK build failed. Check the output above for errors."
        exit 1
    fi
}

# Function to open Android Studio (optional)
open_android_studio() {
    if [ "$1" = "--open-studio" ]; then
        print_status "Opening Android Studio..."
        ionic capacitor open android
    fi
}

# Function to clean build artifacts
clean_build() {
    if [ "$1" = "--clean" ]; then
        print_status "Cleaning build artifacts..."
        rm -rf www
        rm -rf android/app/build
        rm -f app-debug.apk
        print_success "Build artifacts cleaned"
    fi
}

# Function to show help
show_help() {
    echo "Ionic Angular Android Build Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --clean          Clean build artifacts before building"
    echo "  --open-studio    Open Android Studio after build"
    echo "  --help           Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                    # Build APK normally"
    echo "  $0 --clean            # Clean and build APK"
    echo "  $0 --open-studio      # Build APK and open Android Studio"
    echo "  $0 --clean --open-studio  # Clean, build, and open Android Studio"
}

# Main execution
main() {
    echo "=========================================="
    echo "  Ionic Angular Android Build Script"
    echo "=========================================="
    echo ""

    # Parse command line arguments
    CLEAN_BUILD=false
    OPEN_STUDIO=false

    for arg in "$@"; do
        case $arg in
            --clean)
                CLEAN_BUILD=true
                ;;
            --open-studio)
                OPEN_STUDIO=true
                ;;
            --help)
                show_help
                exit 0
                ;;
            *)
                print_error "Unknown option: $arg"
                show_help
                exit 1
                ;;
        esac
    done

    # Execute build steps
    check_prerequisites
    install_dependencies

    if [ "$CLEAN_BUILD" = true ]; then
        clean_build --clean
    fi

    add_android_platform
    build_web_assets
    sync_capacitor
    build_android_apk

    if [ "$OPEN_STUDIO" = true ]; then
        open_android_studio --open-studio
    fi

    echo ""
    print_success "Build process completed successfully!"
    print_status "Your APK is ready for testing!"
    echo ""
}

# Run main function with all arguments
main "$@"
