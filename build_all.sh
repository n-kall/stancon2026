#!/bin/bash

uv run quarto render book
uv run quarto render slides

uv run quarto render exercises/exercises.qmd \
   --profile r

uv run quarto convert exercises/rendered/exercises-r.ipynb \
    --output exercises/rendered/exercises-r.qmd \

uv run quarto render exercises \
  --profile python \

uv run quarto render exercises/exercises.qmd \
  --profile rsolutions

uv run quarto render exercises \
  --profile pythonsolutions
