#!/bin/bash

pandoc -s --from=commonmark static/resume.md -o static/resume.html \
    --metadata pagetitle="Resume - Fernando Trigoso" \
    --metadata author="Fernando Trigoso" \
    --metadata description="Senior Software Engineer. Principal product architect and developer. Writer and speaker. Advanced technical expertise in Dart, Flutter, React, Node, Javascript. Working professionally since 2005."

pandoc -s --from=commonmark static/resume.md -o static/resume.pdf  \
    -V margin-top=1in \
    -V margin-right=1.25in \
    -V margin-bottom=1in \
    -V margin-left=1.25in \
    -V pagestyle=empty \
    -V fontsize=12pt \
    -V fontfamily=times
