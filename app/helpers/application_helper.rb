module ApplicationHelper

    # Returns the full title on a per-page basis.
    def full_title(page_title)
      base_title = 'Dead Pixel'
        if page_title.empty?
          base_title
        else
          "#{base_title} - #{page_title}"
        end
    end

    # Returns a playlist title sans Dead Pixel:
    def playlist_title(title)
      if title.empty?
        "Unnamed"
      else
        title.slice! "Dead Pixel: "
        title
      end
    end
end
