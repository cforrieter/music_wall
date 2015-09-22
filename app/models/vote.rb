class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  after_save :update_score

  def update_score
    self.song.score = Vote.all.where(song_id: song_id).where(upvote: true).count
    song.save
  end
end