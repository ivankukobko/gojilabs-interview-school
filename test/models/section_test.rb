require "test_helper"

class SectionTest < ActiveSupport::TestCase
  test "creates valid section" do
    schedule = schedules(:one)
    teacher_subject = teacher_subjects(:math_teacher_math)
    section = Section.new(
      schedule_id: schedule.id, teacher_subject_id: teacher_subject.id,
      start_at: '08:00', end_at: '08:50',
      start_date: '2024-09-01', end_date: '2024-12-31',
      dow_mon: true
    )

    assert section.valid?
    assert section.save
  end

  test "does not create invalid section" do
    schedule = schedules(:one)
    teacher_subject = teacher_subjects(:math_teacher_math)
    section = Section.new(
      schedule_id: schedule.id, teacher_subject_id: teacher_subject.id,
    )

    assert_not section.valid?
    assert_not section.save
  end
end
