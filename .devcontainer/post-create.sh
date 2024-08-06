#!/bin/bash
sudo chown -R dev:dev node_modules/
git config --global --add safe.directory /workspaces
yarn install --frozen-lockfile