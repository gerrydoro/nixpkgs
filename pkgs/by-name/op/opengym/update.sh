#!/usr/bin/env nix-shell
#!nix-shell -i bash
#!nix-shell -p nix-update

# Bump the openGym version and recompute the main package's npmDepsHash.
nix-update opengym

# The frontend's npmDepsHash can't be targeted by nix-update: opengym.frontend shares its
# version and src with the main package, so there is no independent version to update.
# Recompute it manually and paste the new hash into frontend.nix:
#   nix build .#opengym.frontend   # copy the hash from the error output
