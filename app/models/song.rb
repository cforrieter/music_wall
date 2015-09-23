class Song < ActiveRecord::Base
  has_many :votes

  validates :name, :author, presence: true
  # include in presence, maybe. 
  # then do custom validation for valid youtube url
  # before create fire off the extractor. 
  # after_validation_on_create :youtube_extract
  validate :youtube_validation, on: :create
  before_create :youtube_extract

  def youtube_extract
      if errors.empty? 
      self.url = /https?:\/\/(?:www)?\.?youtube\.\w+\/\w+\?\w+=(\w+)/.match(url).captures[0]
      end
      # unless it passes validation 
  end

  def youtube_validation
    unless /https?:\/\/(?:www)?\.?youtube/.match(url)
      errors.add(:url, "must be a YouTube link!")
    end
  end
end