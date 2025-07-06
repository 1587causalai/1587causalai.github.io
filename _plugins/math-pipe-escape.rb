# frozen_string_literal: true

module Jekyll
  module MathPipeEscape
    # 在 Kramdown 处理之前，将数学公式中的 | 替换为 \vert
    def escape_math_pipes(content)
      return content if content.nil?

      # 处理行内数学公式 $...$
      content = content.gsub(/\$([^\$]+)\$/) do |match|
        math_content = $1
        if math_content.include?('|')
          escaped_content = math_content.gsub('|', ' \\vert ')
          "$#{escaped_content}$"
        else
          match
        end
      end

      # 处理显示数学公式 $$...$$
      content = content.gsub(/\$\$([^\$]+)\$\$/m) do |match|
        math_content = $1
        if math_content.include?('|')
          escaped_content = math_content.gsub('|', ' \\vert ')
          "$$#{escaped_content}$$"
        else
          match
        end
      end

      content
    end
  end

  # Hook 到 Jekyll 的处理流程
  Hooks.register :posts, :pre_render do |post|
    post.content = post.content.extend(MathPipeEscape).escape_math_pipes(post.content)
  end

  Hooks.register :pages, :pre_render do |page|
    page.content = page.content.extend(MathPipeEscape).escape_math_pipes(page.content)
  end
end 