require 'jekyll_asset_pipeline'

module JekyllAssetPipeline
  class ScssConverter < JekyllAssetPipeline::Converter
    require 'sass'

    def self.filetype
      '.scss'
    end

    def convert
      return Sass::Engine.new(@content, syntax: :scss, load_paths: ['../_assets']).render
    end
  end

  class SassConverter < JekyllAssetPipeline::Converter
    require 'sass'

    def self.filetype
      '.sass'
    end

    def convert
      return Sass::Engine.new(@content, syntax: :sass, load_paths: ['../_assets']).render
    end
  end
end
