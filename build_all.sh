#!/bin/bash

# Render R exercises

uv run quarto render exercises/exercises.qmd \
   --profile r

uv run quarto convert exercises/rendered/exercises-r.ipynb \
   --output exercises/rendered/exercises-r.qmd


# Render python exercises
    
uv run quarto render exercises/exercises.qmd \
  --profile python

uv run quarto render exercises/exercises.qmd \
    --profile rsolutions

uv run quarto render exercises \
   --profile pythonsolutions

mkdir -p docs
mkdir -p docs/exercises
mkdir -p docs/slides

rm -f docs/exercises/workflow_exercises.zip

zip --junk-paths docs/exercises/workflow_exercises.zip \
    exercises/stancon2026-workflow-tools.Rproj \
    exercises/rendered/renv.lock \
    exercises/rendered/.Rprofile \
    exercises/rendered/exercises-r.qmd \
    exercises/rendered/exercises-r.org \
    requirements.txt \
    pyproject.toml \
    exercises/rendered/exercises-python.ipynb

(
    cd exercises/rendered &&
    zip -r ../../docs/exercises/workflow_exercises.zip renv/activate.R
)

cp exercises/rendered/exercises-r.html docs/exercises/
cp exercises/rendered/exercises-python.html docs/exercises/

# Render slides
uv run quarto render slides/slides.qmd
cp slides/slides.html docs/slides/
cp -r slides/slides_files docs/slides/

uv run quarto render book
mv book/docs docs
