module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "WorkDay Scheduler"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
end

def link_to_image(image_path, target_link,options={})
  link_to(image_tag(image_path, :border => "0",size: "25x25", alt:"WDS"), target_link, options)
end

end
