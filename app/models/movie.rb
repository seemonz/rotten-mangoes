class Movie < ActiveRecord::Base
  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true}

  validates :description,
    presence: true


  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  # for image uploads when submitting a movie
  mount_uploader :image, ImageUploader

  def review_average
    if reviews.size == 0
      "no reviews!"
    else
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end
  
  # scopes!! not working god damnit!
  scope :title_search, ->(title_mov) { where("title LIKE ?", "#{title_mov}") }
  scope :director_search, ->(dir_mov) { where("director LIKE ?", "#{dir_mov}") } 

  # def self.search_all(keyword)
  #   if !keyword.blank?
  #     where("title like ? or director like ?", "#{keyword}" "#{keyword}")
  #   else 
  #     self.all? 
  #   end
  # end
  # where(director like ? OK title like ?, #keyword, #keyword)

  def self.search_runtime(runtime)
    case runtime
    when 'under90' then self.where("runtime_in_minutes < ?", 90)
    when 'between90and120' then self.where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?", 90, 120 )
    when 'over120' then self.where("runtime_in_minutes > ?", 120)
    else
      self.all
    end
  end


  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "shouldn't be in the future") if release_date > Date.today
    end
  end
end
