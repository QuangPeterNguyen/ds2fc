#!/bin/bash

# List of club IDs to deploy
declare -a clubs=("ds2fc")

# Path to your Flutter source project
FLUTTER_PROJECT_DIR=$(pwd)

# Loop through each club
for club in "${clubs[@]}"
do
  echo "🔧 STARTING DEPLOYMENT for club: $club"
  echo "📦 Step 1: Building Flutter Web for $club..."

  flutter build web

  echo "🧹 Step 2: Cleaning previous gh-pages files (except .git)..."
  cd ../${club}-club-ghpages/

  # Safely clean previous files (leave .git intact)
  git ls-files -z | xargs -0 rm -f
  git clean -fdx

  echo "📁 Step 3: Copying new build files to ${club}-club-ghpages/"
  cp -r ${FLUTTER_PROJECT_DIR}/build/web/* ./
  cp -r ${FLUTTER_PROJECT_DIR}/CNAME ./

  echo "✅ Step 4: Committing changes"
  git add .
  git commit -m "Deploy $club on $(date)"

  echo "📤 Step 5: Pushing to GitHub Pages"
  git push origin release

  echo "✅ FINISHED deployment for $club"
  echo "------------------------------"

  cd ${FLUTTER_PROJECT_DIR}
done

echo "🎉 All deployments completed!"