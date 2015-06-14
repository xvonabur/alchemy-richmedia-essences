module Alchemy
  class EssenceVideo < ActiveRecord::Base
    acts_as_essence ingredient_column: 'attachment',
      preview_text_method: 'name'

    belongs_to :attachment

    before_save :get_metadata,
                if: Proc.new { |video| video.changed? }

    def get_metadata
      if self.attachment && self.attachment.file_uid
        path = "#{Rails.root.join('uploads/attachments').to_s}/#{self.attachment.file_uid}"
        movie = FFMPEG::Movie.new(path)
        self.bitrate = movie.bitrate if movie.bitrate.to_i > 0
        self.width = movie.width if movie.width.to_i > 0
        self.height = movie.height if movie.height.to_i > 0
      end
    end
  end
end
