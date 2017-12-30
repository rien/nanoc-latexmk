# frozen_string_literal: true

require 'tmpdir'

module Nanoc::Latexmk::Filters

  class LatexmkFilter < Nanoc::Filter
    identifier :latexmk

    type :text => :binary

    TMPFILE_NAME = 'nanoc-latexmk.tex'

    ENGINES = {
      pdflatex: '-pdf',
      xelatex:  '-xelatex'
    }.freeze

    LATEX_PARAMS = %w[-interaction=nonstopmode -halt-on-error -file-line-error].freeze

    DEFAULT_PARAMS = {
      engine: :pdflatex,
      command_params: LATEX_PARAMS,
      shell_escape: false
    }.freeze

    def run(content, params = {})
      params = DEFAULT_PARAMS.merge(params)

      raise 'Unknown Engine' unless ENGINES.key? params[:engine].to_sym

      latex_params = []
      latex_params += params[:command_params]

      latex_params << if params[:shell_escape]
                         '-shell-escape'
                       else
                         '-no-shell-escape'
                       end

      Dir.mktmpdir do |dir|
        File.open(File.join(dir, TMPFILE_NAME), 'w') do |f|
          f.write(content)
          f.flush

          latexmk_command = ['latexmk', ENGINES[params[:engine].to_sym]] \
                            + latex_params.map { |p| '-latexoption=' + p } \
                            + ["-output-directory=#{dir}", f.path ]

          puts "Running latexmk command: #{latexmk_command}"

          raise 'Build Error' unless system(*latexmk_command)
          system('mv', f.path.sub('.tex', '.pdf'), output_filename)
        end
      end
    end
  end
end
