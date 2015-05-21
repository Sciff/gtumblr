class Location < ActiveRecord::Base

  belongs_to :user

  validates :title, :address, :user, :latitude, :longitude, presence: true

  before_validation :set_title

  scope :desc_order, -> { order('updated_at desc') }

  private

  def set_title
    self.title = self.address if self.title.blank?
  end

end
