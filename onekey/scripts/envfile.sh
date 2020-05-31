#!/usr/bin/env bash
export $(grep -v '^#' ~/.tlgame/gs/.env | xargs -d '\n')