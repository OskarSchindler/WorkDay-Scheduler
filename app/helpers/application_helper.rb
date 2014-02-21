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

	def image_path
	image_path ="app/assets/images/wds_small.jpg"
	end
 
end
