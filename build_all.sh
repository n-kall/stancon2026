#!/bin/bash

uv run quarto render book
uv run quarto render slides

uv run quarto render exercises \
   --profile r \
   --output exercises-r.ipynb

uv run quarto convert exercises-r.ipynb \
       --output exercises-r.qmd

uv run quarto render exercises \
  --profile python \
  --output exercises-python.ipynb

uv run quarto render exercises \
  --profile r-solutions \
  --to html \
  --execute \
  -M execute.output:true \
  -M execute.echo:true \
  -M execute.warning:false \
  --output solutions-r.html

uv run quarto render exercises \
  --profile python-solutions \
  --to html \
  --execute \
  -M execute.output:true \
  -M execute.echo:true \
  -M execute.warning:false \
  --output solutions-python.html
