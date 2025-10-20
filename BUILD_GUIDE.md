# Ionic Angular Android Build Guide

This project includes automated scripts to build Android APKs from your Ionic Angular application.

## Quick Start

### Option 1: Using the Bash Script (Recommended)

```bash
# Build APK normally
./build-android.sh

# Clean build artifacts and build APK
./build-android.sh --clean

# Build APK and open Android Studio
./build-android.sh --open-studio

# Clean, build, and open Android Studio
./build-android.sh --clean --open-studio

# Show help
./build-android.sh --help
```

### Option 2: Using npm Scripts

```bash
# Build production web assets and Android APK
npm run android:build

# Sync Capacitor with Android project
npm run android:sync

# Open Android Studio
npm run android:open

# Clean build artifacts
npm run android:clean
```

## What the Scripts Do

### Bash Script (`build-android.sh`)
1. **Prerequisites Check**: Verifies Node.js, npm, and Ionic CLI are installed
2. **Dependencies**: Installs project dependencies
3. **Android Platform**: Adds Android platform if not already present
4. **Web Build**: Builds production web assets
5. **Capacitor Sync**: Syncs web assets with Android project
6. **APK Build**: Builds the Android APK
7. **File Management**: Copies APK to project root for easy access

### npm Scripts
- `android:build`: Complete build process (production build + sync + APK build)
- `android:sync`: Sync web assets with Android project
- `android:open`: Open Android Studio
- `android:clean`: Clean build artifacts

## Prerequisites

Before running the build scripts, ensure you have:

1. **Node.js** (v16 or higher)
2. **npm** (comes with Node.js)
3. **Ionic CLI** (will be installed automatically if missing)
4. **Android Studio** (for opening the project)
5. **Java Development Kit (JDK)** (for Android development)

## Output Files

After a successful build, you'll find:
- **APK File**: `app-debug.apk` in the project root
- **Android Project**: `android/` directory with the native Android project
- **Web Assets**: `www/` directory with built web assets

## Troubleshooting

### Common Issues

1. **"Ionic CLI not found"**
   ```bash
   npm install -g @ionic/cli
   ```

2. **"Android platform not found"**
   ```bash
   ionic capacitor add android
   ```

3. **"Build failed"**
   - Check that all dependencies are installed: `npm install`
   - Ensure Android Studio and JDK are properly installed
   - Try cleaning build artifacts: `npm run android:clean`

4. **"APK not found"**
   - Check the build output for errors
   - Verify Android Studio is properly configured
   - Try running: `ionic capacitor build android --verbose`

### Manual Steps (if scripts fail)

If the automated scripts don't work, you can run the steps manually:

```bash
# 1. Install dependencies
npm install

# 2. Add Android platform (if needed)
ionic capacitor add android

# 3. Build web assets
ionic build --prod

# 4. Sync with Android
ionic capacitor sync android

# 5. Build APK
ionic capacitor build android

# 6. Open Android Studio (optional)
ionic capacitor open android
```

## Development Workflow

1. **Make changes** to your Ionic Angular app
2. **Test in browser**: `ionic serve`
3. **Build APK**: `./build-android.sh` or `npm run android:build`
4. **Test on device**: Install the generated APK

## File Structure

```
playground-ionic/
├── build-android.sh          # Main build script
├── package.json              # npm scripts
├── android/                  # Android project
├── www/                      # Built web assets
├── app-debug.apk            # Generated APK
└── src/                     # Source code
```

## Next Steps

- Install the APK on an Android device for testing
- Use Android Studio to customize the native Android project
- Configure app icons and splash screens
- Set up signing for release builds
- Deploy to Google Play Store

For more information, visit the [Ionic Capacitor documentation](https://capacitorjs.com/docs).
