#!/bin/bash

pandoc -s --from=commonmark static/resume.md -o static/resume.html \
    --metadata pagetitle="Resume - Fernando Trigoso" \
    --metadata description="Senior Software Engineer. Principal product architect and developer. Writer and speaker. Advanced technical expertise in Dart, Flutter, React, Node, Javascript. Working professionally since 2005."
