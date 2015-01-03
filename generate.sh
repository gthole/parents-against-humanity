#!/bin/bash

set -e

# Make sure submodule installed
if [ ! -d "bbcards" ]; then
  git submodule update
fi

cd bbcards

# Install the gem dependency
gem install prawn

# Run the generation code
./bbcards.rb -s \
  -i default.png \
  -b ../black.txt \
  -w ../white.txt \
  -o ../parents-against-humanity.pdf

echo "Generated cards to parents-against-humanity.pdf"
