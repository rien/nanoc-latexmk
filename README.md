# Nanoc-latexmk

[Nanoc](https://nanoc.ws/) filter to compile `.tex` files to pdf using the `latexmk` command. Supports both `pdflatex` and `xelatex`.

## System requirements

You need everything to build your LaTeX file manually, so `latexmk`, `pdflatex` and `xelatex` need to be installed on your system.

## Installation

To use this filter, add nanoc-latexmk to your `Gemfile`.
```
gem 'nanoc-latexmk'
```
Then require this project in your `Rules`:
```
require 'nanoc/latexmk'
```

## Usage

First, be sure to add `tex` to the `text_extensions` in your `nanoc.yaml`.

With a basic file in `content/file.tex`:

```
---
title: Hello
---
\section{World}
```
And a layout in `layouts/default.tex.erb`
```
\documentclass{article}
\title{<%= item[:title] %>}
\begin{document}
\maketitle
<%= yield %>
\end{document}
```
You can add this to your `Rules`
```
compile '/**/*.tex', rep: :pdf do
  layout '/default.tex.erb'
  filter :latexmk
  write ext: 'pdf'
end
```

Results in:
![Hello World PDF](https://user-images.githubusercontent.com/3226995/34323260-3995578a-e841-11e7-9aeb-b1e2ae6e84a6.png)

## Licence

See the [UNLICENSE](https://github.com/rien/nanoc-latexmk/blob/master/LICENSE) for details.

## Author
Rien Maertens [maertensrien@gmail.com](mailto:maertensrien@gmail.com)

## Changelog

See the [CHANGELOG](https://github.com/rien/nanoc-latexmk/blob/master/CHANGELOG.md) for details.

