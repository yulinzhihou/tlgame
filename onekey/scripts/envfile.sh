#!/usr/bin/env bash
export $(grep -v '^#' ~/.tlgame/onekey/.env | xargs -d '\n')