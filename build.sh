#!/bin/sh
# baut die Seite nach docs/ (wird von GitHub Pages ausgeliefert)
cd "$(dirname "$0")" || exit 1

zola build --output-dir docs --force
