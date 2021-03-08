module WorksHelper
  def work_lists(works)
    html = ""
    works.each do |work|
      html += render(partial: "works", locals: {work: work})
    end
  end
end
