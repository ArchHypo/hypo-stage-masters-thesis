# Root latexmkrc — tells LaTeX where to find template files,
# then loads the template's own build configuration.

ensure_path('TEXINPUTS', './template//');
ensure_path('BSTINPUTS', './template//');

do 'template/latexmkrc';
