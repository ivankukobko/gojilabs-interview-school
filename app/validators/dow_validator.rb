class DowValidator < ActiveModel::Validator
  def validate(record)
    unless Section::DOW_FIELDS.any? { |dow| record[dow] }
      record.errors.add(:base, "should be at least 1 day per week")
    end
  end
end
