module SolutionHelper
  def render_code(code)
    CodeRay.scan(code, :ruby).div.html_safe
  end

  def convert_to_ms(seconds)
    (seconds*1000).round
  end
end
