#!/bin/bash

# clean up previous runs
rm -r docs
rm -r exercises_source/rendered
# Render R exercises

uv run quarto render exercises_source/exercises.qmd --no-execute \
   --profile r

uv run quarto render exercises_source/exercises.qmd \
    --profile rsolutions

uv run quarto convert exercises_source/rendered/exercises-r.ipynb \
   --output exercises_source/rendered/exercises-r.qmd


# Render python exercises
    
uv run quarto render exercises_source/exercises.qmd --no-execute \
  --profile python

uv run quarto render exercises_source/exercises.qmd \
   --profile pythonsolutions

# Move to correct place

mkdir -p docs
mkdir -p docs/exercises
mkdir -p docs/slides

(
    cd exercises_source/rendered &&
        Rscript ../../prepare_env.R
)

zip --junk-paths docs/exercises/workflow_exercises.zip \
    exercises_source/stancon2026-workflow-tools.Rproj \
    exercises_source/rendered/renv.lock \
    exercises_source/rendered/.Rprofile \
    exercises_source/rendered/exercises-r.qmd \
    exercises_source/rendered/exercises-r.org \
    requirements.txt \
    pyproject.toml \
    exercises_source/birds_per_year.stan \
    exercises_source/rendered/exercises-python.ipynb

(
    cd exercises_source/rendered &&
    zip -r ../../docs/exercises/workflow_exercises.zip renv/activate.R
)

(
    cd exercises_source
    zip -r ../docs/exercises/workflow_exercises.zip data/
)

cp -r exercises_source/rendered/exercises-* docs/exercises/
cp -r exercises_source/rendered/solutions-* docs/exercises/
cp -r exercises_source/rendered/exercises_files docs/exercises/

# copy rendered exercises to be used for the web version
cp exercises_source/rendered/exercises-r.qmd exercise_notebooks
cp exercises_source/rendered/exercises-r.ipynb exercise_notebooks
cp exercises_source/rendered/exercises-python.ipynb exercise_notebooks


# Render slides
uv run quarto render slides/slides.qmd
cp slides/slides.html docs/slides/
cp -r slides/slides_files docs/slides/
cp -r slides/img docs/slides/

uv run quarto render book
rsync -r book/docs/ docs/
