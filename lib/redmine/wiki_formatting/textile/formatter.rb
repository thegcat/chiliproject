#-- encoding: UTF-8
#-- copyright
# ChiliProject is a project management system.
#
# Copyright (C) 2010-2011 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# See doc/COPYRIGHT.rdoc for more details.
#++


module Redmine
  module WikiFormatting
    module Textile
      class Formatter < RedCloth::TextileDoc
        include ActionView::Helpers::TagHelper

        def initialize(*args)
          super
          self.filter_styles=true
          self.no_span_caps=true
        end

        def before_transform(text)
          text = foo
          super
          escape_html_tags text
          email_like_quotes text
        end

        def to_html( *rules )
          rules.unshift :escape_html_tags, :block_textile_quotes
          apply_rules(rules)

          to(RedCloth::Formatters::HTML)
        end

        QUOTES_RE = /(^>+([^\n]*?)(\n|$))+/m
        QUOTES_CONTENT_RE = /^([> ]+)(.*)$/m

        def block_textile_quotes( text )
          text.gsub!( QUOTES_RE ) do |match|
            lines = match.split( /\n/ )
            quotes = ''
            indent = 0
            lines.each do |line|
              line =~ QUOTES_CONTENT_RE
              bq,content = $1, $2
              l = bq.count('>')
              if l != indent
                quotes << ("\n\n" + (l>indent ? '<blockquote>' * (l-indent) : '</blockquote>' * (indent-l)) + "\n\n")
                indent = l
              end
              quotes << (content + "\n")
            end
            quotes << ("\n" + '</blockquote>' * indent + "\n\n")
            quotes
          end
        end

        ALLOWED_TAGS = %w(redpre pre code notextile)

        def escape_html_tags(text)
          text.gsub!(%r{<(\/?([!\w]+)[^<>\n]*)(>?)}) {|m| ALLOWED_TAGS.include?($2) ? "<#{$1}#{$3}" : "&lt;#{$1}#{'&gt;' unless $3.blank?}" }
        end
      end
    end
  end
end
