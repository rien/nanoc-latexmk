# frozen_string_literal: true

require 'tmpdir'

module Nanoc::Latexmk::Filters
  class LatexmkFilter < Nanoc::Filter
    identifier :latexmk

    type :text => :binary

    TMPFILE_NAME = 'nanoc-latexmk.tex'

    ENGINES = {
      pdflatex: { cmd: %w[pdflatex], param: '-pdf' },
      xelatex:  { cmd: %w[xelatex], param: '-xelatex' }
    }.freeze

    LATEX_PARAMS = %w[-interaction=nonstopmode -halt-on-error].freeze

    DEFAULT_PARAMS = {
      engine: :pdflatex,
      command_params: LATEX_PARAMS,
      shell_escape: false
    }.freeze

    def run(content, params = {})
      params = DEFAULT_PARAMS.merge(params)

      raise 'Unknown Engine' unless ENGINES.key? params[:engine].to_sym
      engine = ENGINES[params[:engine].to_sym]

      latex_command = engine[:cmd]

      latex_command += params[:command_params]

      latex_command << if params[:shell_escape]
                         '-shell-escape'
                       else
                         '-no-shell-escape'
                       end

      Dir.mktmpdir do |dir|
        File.open(File.join(dir, TMPFILE_NAME), 'w') do |f|
          f.write(content)
          f.flush

          latexmk_command = ['latexmk',
                             engine[:param],
                             "-latex=\"#{latex_command.join(' ')}\"",
                             "-output-directory=#{dir}",
                             f.path]

          raise 'Build Error' unless system(*latexmk_command)
          system('mv', f.path.sub('.tex', '.pdf'), output_filename)

        end
      end
    end
  end
end
