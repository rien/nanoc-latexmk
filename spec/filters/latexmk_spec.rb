# frozen_string_literal: true

require 'spec_helper'
require 'byebug'
require 'timeout'

describe Nanoc::Latexmk::Filters::LatexmkFilter do
  before(:each) do
    @filter = described_class.new
    @input = <<~HEREDOC
      \\documentclass[12pt]{article}
      \\begin{document}
      Hello world!
      \\end{document}
    HEREDOC
    @pdf_magic_bytes = '%PDF'
  end

  describe '.run' do
    it 'compile to pdf' do
      expect(@filter.run(@input)).to be_truthy

      result = File.read @filter.output_filename
      expect(result.slice(0, @pdf_magic_bytes.length)).to eql(@pdf_magic_bytes)
    end

    it 'compile to pdf using xelatex' do
      expect(@filter.run(@input, engine: :xelatex)).to be_truthy

      result = File.read @filter.output_filename
      expect(result.slice(0, @pdf_magic_bytes.length)).to eql(@pdf_magic_bytes)
    end

    it 'crash without user interaction' do
      @broken_input = <<~HEREDOC
        \\documentclass{article}
        \\begin{document}
          \\foobar
        \\end{document}
      HEREDOC

      Timeout::timeout(1) do
        expect { @filter.run(@broken_input) }.to raise_error('Build Error')
      end
    end
  end
end
