#!/bin/bash

# clean up previous runs
rm -r docs
rm -r exercises/rendered
# Render R exercises

uv run quarto render exercises/exercises.qmd \
   --profile r

uv run quarto render exercises/exercises.qmd \
    --profile rsolutions

uv run quarto convert exercises/rendered/exercises-r.ipynb \
   --output exercises/rendered/exercises-r.qmd


# Render python exercises
    
uv run quarto render exercises/exercises.qmd \
  --profile python

uv run quarto render exercises/exercises.qmd \
   --profile pythonsolutions

# Move to correct place

mkdir -p docs
mkdir -p docs/exercises
mkdir -p docs/slides

(
    cd exercises/rendered &&
        Rscript ../../prepare_env.R
)

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

(
    cd exercises
    zip -r ../docs/exercises/workflow_exercises.zip data/
)

cp -r exercises/rendered/exercises-* docs/exercises/
cp -r exercises/rendered/solutions-* docs/exercises/
cp -r exercises/rendered/exercises_files docs/exercises/


# Render slides
uv run quarto render slides/slides.qmd
cp slides/slides.html docs/slides/
cp -r slides/slides_files docs/slides/
cp -r slides/img docs/slides/

uv run quarto render book
rsync -r book/docs/ docs/
