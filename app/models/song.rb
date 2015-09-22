class Song < ActiveRecord::Base
  has_many :votes

  validates :name, :author, presence: true
  validates :url, format: { with: /https?:\/\/(?:www)?\.?youtube/, message: "must be link from YouTube."}
  validate :youtube_validation

  def youtube_validation
    unless url.empty?
      self.url = /https?:\/\/(?:www)?\.?youtube\.\w+\/\w+\?\w+=(\w+)/.match(url).captures[0]
    end
  end
end