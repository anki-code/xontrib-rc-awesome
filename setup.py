#!/usr/bin/env python
import setuptools

try:
    with open('README.md', 'r', encoding='utf-8') as fh:
        long_description = fh.read()
except (IOError, OSError):
    long_description = ''

setuptools.setup(
    name='xontrib-rc-awesome',
    version='0.0.6',
    license='MIT',
    author='anki-code',
    author_email='no@no.no',
    description="Awesome snippets of code for xonshrc in xonsh shell.",
    long_description=long_description,
    long_description_content_type='text/markdown',
    python_requires='>=3.6',
    install_requires=[
        'xonsh', # The awesome shell.
        'xontrib-prompt-bar', # The bar prompt for xonsh shell with customizable sections and Starship support. 
        'xontrib-back2dir', # Return to the most recently used directory when starting the xonsh shell. 
        'xontrib-sh', # Paste and run commands from bash, zsh, fish, tcsh in xonsh shell. 
        'xontrib-pipeliner', # Let your pipe lines flow thru the Python code in xonsh. 
        'xontrib-output-search', # Get identifiers, names, paths, URLs and words from the previous command output and use them for the next command in xonsh. 
        'xontrib-argcomplete', # Argcomplete support to tab completion of python and xonsh scripts in xonsh shell. 
    ],
    extras_require={
        "xxh": ["xxh-xxh"],
    },
    packages=['xontrib'],
    package_dir={'xontrib': 'xontrib'},
    package_data={'xontrib': ['*.py', '*.xsh']},    
    platforms='any',
)
