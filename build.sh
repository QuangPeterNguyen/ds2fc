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
  #copy theme.dart
  cp ${FLUTTER_PROJECT_DIR}/fc_configs/$club/theme.dart ${FLUTTER_PROJECT_DIR}/web_source/lib/
  #copy imagges
  cp -r ${FLUTTER_PROJECT_DIR}/fc_configs/$club/images/* ${FLUTTER_PROJECT_DIR}/web_source/assets/images/
  #copy translations
  cp -r ${FLUTTER_PROJECT_DIR}/fc_configs/$club/translations/* ${FLUTTER_PROJECT_DIR}/web_source/assets/translations/
  #copy web
  cp -r ${FLUTTER_PROJECT_DIR}/fc_configs/$club/web/* ${FLUTTER_PROJECT_DIR}/web_source/web/


  echo "📦 Step 2: Building Flutter Web for $club..."
  cd web_source
  flutter build web

  echo "🧹 Step 3: Cleaning previous gh-pages files (except .git)..."
  cd ../../${club}-club-ghpages/

  # Safely clean previous files (leave .git intact)
  git ls-files -z | xargs -0 rm -f
  git clean -fdx

  echo "📁 Step 4: Copying new build files to ${club}-club-ghpages/"
  cp -r ${FLUTTER_PROJECT_DIR}/web_source/build/web/* ./
  cp ${FLUTTER_PROJECT_DIR}/fc_configs/$club/CNAME ./

  echo "✅ FINISHED bulding for $club"
  echo "------------------------------"

  cd ${FLUTTER_PROJECT_DIR}

   #echo "📦 Step 5: Revert back to ds2fc soure: Copying Files from ds2fc folder to web_source folder..."
  #copy config.dart
  #cp ${FLUTTER_PROJECT_DIR}/fc_configs/ds2fc/config.dart ${FLUTTER_PROJECT_DIR}/web_source/lib/
  #copy imagges
  #cp -r ${FLUTTER_PROJECT_DIR}/fc_configs/ds2fc/images/* ${FLUTTER_PROJECT_DIR}/web_source/assets/images/
  #copy translations
  #cp -r ${FLUTTER_PROJECT_DIR}/fc_configs/ds2fc/translations/* ${FLUTTER_PROJECT_DIR}/web_source/assets/translations/
  #copy web
  #cp -r ${FLUTTER_PROJECT_DIR}/fc_configs/ds2fc/web/* ${FLUTTER_PROJECT_DIR}/web_source/web/
done

echo "🎉 All builds completed!"
read -n 1 -s -r -p "👉 Press any key to exit..."