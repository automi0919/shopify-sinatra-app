#!/usr/bin/env bash

set -euo pipefail

echo "🚀 Starting setup..."

if [ ! -d "example" ]; then
  echo "❌ 'example' directory not found."
  exit 1
fi

cd example

echo "📦 Installing dependencies..."
bundle check || bundle install --jobs 4 --retry 3

echo "🗄 Running database migrations..."
bundle exec rake db:migrate

echo "🧪 Preparing test database..."
bundle exec rake db:test:prepare || true

echo "🧪 Running tests..."
bundle exec rake test

echo "✅ Done."
