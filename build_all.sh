#!/bin/bash

uv run quarto render exercises/exercises.qmd \
   --profile r

uv run quarto convert exercises/rendered/exercises-r.ipynb \
    --output exercises/rendered/exercises-r.qmd \

uv run quarto render exercises/exercises.qmd \
  --profile python

uv run quarto render exercises/exercises.qmd \
    --profile rsolutions

uv run quarto render exercises \
   --profile pythonsolutions

mkdir -p rendered_website
mkdir -p rendered_website/exercises
mkdir -p rendered_website/slides
cp -r exercises/rendered/* rendered_website/exercises/
cp slides/slides.html rendered_website/slides/
cp -r slides/slides_files rendered_website/slides/

uv run quarto render book
uv run quarto render slides/slides.qmd

