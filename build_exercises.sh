#!/bin/bash


# Generate the R Jupyter notebook
quarto render exercises.qmd \
  --profile r \
  --to ipynb \
  --output exercises-r.ipynb

# Convert the R notebook to a quarto document
quarto convert exercises-r.ipynb \
  --output exercises-r.qmd

# Generate the Python Jupyter notebook
quarto render exercises.qmd \
  --profile python \
  --to ipynb \
  --output exercises-python.ipynb

# Convert the Python notebook to a quarto document
quarto convert exercises-python.ipynb \
  --output exercises-python.qmd

# Render solutions
quarto render exercises.qmd \
  --profile r-solutions \
  --to html \
  --execute \
  -M execute.output:true \
  -M execute.echo:true \
  -M execute.warning:false \
  --output solutions-r.html

quarto render exercises.qmd \
  --profile python-solutions \
  --to html \
  --execute \
  -M execute.output:true \
  -M execute.echo:true \
  -M execute.warning:false \
  --output solutions-python.html
