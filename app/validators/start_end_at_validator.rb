class StartEndAtValidator < ActiveModel::Validator
  attr_reader :record, :start_at, :end_at

  MIN_START_AT = Time.parse('7:30').freeze
  MAX_START_AT = Time.parse('21:40').freeze
  MIN_END_AT = Time.parse('8:20').freeze
  MAX_END_AT = Time.parse('22:30').freeze

  def validate(record)
    return unless record.start_at && record.end_at

    @record = record
    @start_at = Time.parse(I18n.l(record.start_at, format: :hours))
    @end_at = Time.parse(I18n.l(record.end_at, format: :hours))

    _check_start_at_min
    _check_start_at_max
    _check_end_at_min
    _check_end_at_max
  end

  private

  def _check_start_at_min
    return if start_at >= MIN_START_AT

    record.errors.add(:start_at, "should start at or after #{MIN_START_AT}")
  end

  def _check_start_at_max
    return if start_at <= MAX_START_AT

    record.errors.add(:start_at, "should start at or before #{MIN_END_AT}")
  end

  def _check_end_at_min
    return if end_at >= MIN_END_AT

    record.errors.add(:end_at, "should end at or after #{MIN_END_AT}")
  end

  def _check_end_at_max
    return if end_at <= MAX_END_AT

    record.errors.add(:end_at, "should end at or before #{MAX_END_AT}")
  end
end
