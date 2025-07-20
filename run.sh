#!/bin/bash

# List of club IDs to deploy
declare -a clubs=("ds2fc")

# Path to your Flutter source project
FLUTTER_PROJECT_DIR=$(pwd)

# Loop through each club
for club in "${clubs[@]}"
do
  echo "🔧 STARTING Building for club: $club"
  echo "📦 Step 1: Copying Files from $club folder to web_source folder..."
  #copy config.dart
  cp ${FLUTTER_PROJECT_DIR}/fc_configs/$club/config.dart ${FLUTTER_PROJECT_DIR}/web_source/lib/
  #copy imagges
  cp -r ${FLUTTER_PROJECT_DIR}/fc_configs/$club/images/* ${FLUTTER_PROJECT_DIR}/web_source/assets/images/
  #copy translations
  cp -r ${FLUTTER_PROJECT_DIR}/fc_configs/$club/translations/* ${FLUTTER_PROJECT_DIR}/web_source/assets/translations/
  #copy web
  cp -r ${FLUTTER_PROJECT_DIR}/fc_configs/$club/web/* ${FLUTTER_PROJECT_DIR}/web_source/web/


  echo "📦 Step 2: Building Flutter Web for $club..."
  cd web_source
  flutter run -d web-server
done