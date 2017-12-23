require 'spec_helper'
require 'byebug'

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
  end
end
