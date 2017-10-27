#!/bin/bash
for repo in repos/*; do echo $(git --git-dir $repo/.git rev-parse HEAD) $repo; done
