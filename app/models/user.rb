class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :movies, dependent: :destroy
  has_many :user_latest_uploads, dependent: :destroy

  def has_this_movie_name?(original_name, imdb_title)
    movies.where(name: original_name, imdb_name: imdb_title).present?
  end

  def create_chrome_app_session_id
    sha = Digest::SHA1.hexdigest([Time.now, rand].join)
    update_attributes(chrome_app_session_id: sha)
    return chrome_app_session_id
  end

end
