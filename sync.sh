#!/bin/zsh
# Copy blog.md from the HW repo as index.md (with MathJax header) and copy every image it links to.
set -e
SRC=/Users/bugra/Desktop/HDRI/homewroks/hw1_crf
DST=/Users/bugra/Desktop/HDRI/hw1-blog
cd "$DST"
rm -rf results data
{
cat <<'H'
<script>
MathJax = { tex: { inlineMath: [['$', '$'], ['\\(', '\\)']], displayMath: [['$$', '$$'], ['\\[', '\\]']] } };
</script>
<script src="https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-mml-chtml.js"></script>

H
cat "$SRC/blog.md"
} > index.md
grep -o '](\(results\|data\)/[^)]*)' "$SRC/blog.md" | sed 's/^](//; s/)$//' | sort -u | while read -r f; do
  mkdir -p "$(dirname "$f")"; cp "$SRC/$f" "$f"
done
echo "synced: $(find results data -type f | wc -l | tr -d ' ') images"
