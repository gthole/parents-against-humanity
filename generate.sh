#!/bin/bash

set -e

# Make sure submodule installed
if [ ! -d "bbcards" ]; then
  git submodule update
fi

cd bbcards

# Install the gem dependency
if ! gem list --local | grep prawn
  then gem install prawn
fi

# Run the generation code
./bbcards.rb -s \
  -i default.png \
  -b ../black.txt \
  -w ../white.txt \
  -o ../parents-against-humanity.pdf

echo "Generated cards to parents-against-humanity.pdf"

if [ ! -f "../cardbacks.pdf" ]; then
  echo "Generating card backs"
  mkdir -p ../tmp
  for i in {1..20}; do
    echo "\\n Parents\\n Against Humanity" >> ../tmp/black.txt
    echo "\\n Parents\\n Against Humanity" >> ../tmp/white.txt
  done
  ./bbcards.rb -s -g \
    -b ../tmp/black.txt \
    -w ../tmp/white.txt \
    -o ../cardbacks.pdf
  rm ../tmp/black.txt ../tmp/white.txt
fi

