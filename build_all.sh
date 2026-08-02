#!/bin/bash

uv run quarto render
uv run quarto render slides.qmd
uv run bash build_exercises.sh 


