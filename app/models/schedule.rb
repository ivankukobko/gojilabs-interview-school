class Schedule < ApplicationRecord
  # belongs_to :student
  has_many :sections, dependent: :destroy
  has_many :subjects, through: :sections

  accepts_nested_attributes_for :sections, reject_if: proc { |attrs| attrs['teacher_subject_id'].blank? },
                                           allow_destroy: true
end
