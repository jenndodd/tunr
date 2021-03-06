class User < ActiveRecord::Base
  has_many :purchases
  has_many :songs, through: :purchases
  has_many :playlists
  has_many :playlist_users
  has_many :shared_playlists, through: :playlist_users, source: :playlist

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :dob, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  
  has_secure_password

  def purchase(song)
    if update(balance: balance - song.price)
      self.songs << song
    end
  end
end