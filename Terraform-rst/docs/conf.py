# Configuration file for the Sphinx documentation builder.

# -- Project information

project = 'Day 0 Beginners Guide to Terraform'
copyright = '2022, Jesse Driskill'
author = 'Jesse Driskill'

release = '0.1'
version = '0.1.0'

# -- General configuration
extensions = [
    'sphinx.ext.autosectionlabel',
    'sphinx.ext.autodoc',
    'sphinx.ext.doctest',
    'sphinx.ext.coverage',
    'sphinx.ext.mathjax',
    'sphinx.ext.viewcode',
    'sphinx.ext.todo'
]

todo_include_todos = True

# source_suffix = ['.rst', '.md']
source_suffix = '.rst'

# The master toctree document.
master_doc = 'index'

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'sphinx'

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']


# -- Options for HTML output
#html_theme = 'sphinx_rtd_theme'

# -- Options for EPUB output
epub_show_urls = 'footnote'
