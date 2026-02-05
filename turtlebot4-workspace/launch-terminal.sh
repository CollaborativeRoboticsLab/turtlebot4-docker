#!/bin/bash
set -e

# Always launch xterm for a minimal footprint
exec xterm -fa 'Monospace' -fs 11 -geometry 120x30 -e bash -i
